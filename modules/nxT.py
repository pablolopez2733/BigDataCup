#Load modules
import pandas as pd
from typing import Callable, List, Tuple
import numpy as np
from pandera.typing import DataFrame, Series
try:
    from scipy.interpolate import interp2d
except ImportError:
    interp2d = None
import xTa as xTa

M: int = 8
N: int = 16
    
def move_turnover_matrix(actions, l: int = N, w: int = M) -> np.ndarray:
    move_actions = xTa.get_move_actions(actions)
    X = pd.DataFrame()
    X['start_cell'] = xTa._get_flat_indexes(move_actions.start_x, move_actions.start_y, l, w)
    X['end_cell'] = xTa._get_flat_indexes(move_actions.end_x, move_actions.end_y, l, w)
    X['success'] = move_actions.success

    vc = X.start_cell.value_counts(sort=False)
    start_counts = np.zeros(w * l)
    start_counts[vc.index] = vc

    turnover_matrix = np.zeros((w * l, w * l))
    
    for i in range(0, w * l):
        vc2 = X[((X.start_cell == i) & (X.success == 0.0))].end_cell.value_counts(
            sort=False)
        turnover_matrix[i, vc2.index] = vc2 / start_counts[i]

    return turnover_matrix
    
####### transform matrix to nxT     
def estimate_nxTa_matrix(actions,t,verbose=True) -> np.array:
    w = 8
    l = 16
    actions=actions[actions['time'] == t].copy()
    xTModel = xTa.ExpectedThreat(16, 8)
    xTModel.fit(actions,t)
    xt_matrix = xTModel.xT
    xt = xt_matrix.reshape(w*l)
    vec = np.zeros(w*l)
    vec2 = np.zeros(w*l)
    if verbose:
        print('Transforming Matrix')
    for i in range(0,w*l):
        if verbose:
            print('Iteration ',str(i+1),'of ',str(w*l))
        uniform_data = np.flip(move_turnover_matrix(actions, l, w)[i])
        oxt = (xt * uniform_data).sum()
        nxt = xt[i] - oxt
        vec[i]=nxt
        vec2[i]=oxt
    oxt_matrix = vec2.reshape(w,l)
    nxt_matrix = vec.reshape(w,l)
    return nxt_matrix, oxt_matrix,xt_matrix
###
# Function to get nxTa per time: store in net_xT_augmented_matrices folder
#####

def nxTa_matrix(t):
    df = pd.read_csv(
        "../modules/net_xT_augmented_matrices/nxTa_"+str(t)+".csv",
    header=None)
    return df.values

def oxTa_matrix(t):
    df = pd.read_csv(
        "../modules/oxT_augmented_matrices/oxTa_"+str(t)+".csv",
    header=None)
    return df.values

def xTa_matrix_(t):
    df = pd.read_csv(
        "../modules/xT_augmented_matrices/xTa_"+str(t)+".csv",
    header=None)
    return df.values

def get_nxTa(actions,t) -> np.array:
    l = 16
    w = 8
    grid = nxTa_matrix(t)
    actions = actions[actions['time'] == t]
    startxc, startyc = xTa._get_cell_indexes(actions.start_x, actions.start_y, l, w)
    endxc, endyc = xTa._get_cell_indexes(actions.end_x, actions.end_y, l, w)
    xT_start = grid[w - 1 - startyc, startxc]
    xT_end = grid[w - 1 - endyc, endxc]
    nxTa = xT_end - xT_start
    return xT_start , xT_end, nxTa

def get_oxTa(actions,t) -> np.array:
    l = 16
    w = 8
    grid = oxTa_matrix(t)
    actions = actions[actions['time'] == t]
    startxc, startyc = xTa._get_cell_indexes(actions.start_x, actions.start_y, l, w)
    endxc, endyc = xTa._get_cell_indexes(actions.end_x, actions.end_y, l, w)
    oxTa_start = grid[w - 1 - startyc, startxc]
    return oxTa_start

def get_xTa(actions,t) -> np.array:
    l = 16
    w = 8
    grid = xTa_matrix_(t)
    actions = actions[actions['time'] == t]
    startxc, startyc = xTa._get_cell_indexes(actions.start_x, actions.start_y, l, w)
    endxc, endyc = xTa._get_cell_indexes(actions.end_x, actions.end_y, l, w)
    xTa_start = grid[w - 1 - startyc, startxc]
    return xTa_start

def return_nxTa_values(actions) -> np.ndarray:
    import xTa as xTa
    x = actions.start_x
    y = actions.start_y
    l=16
    w=8
    lst = []
    xTModel = xTa.ExpectedThreat(l=16, w=8)
    for t in range(1,5):    
        data_=actions[actions['time'] == t].copy()
        x=data_.start_x
        y=data_.start_y
        indx = data_.index
        xTModel.fit(data_,t)
        start,end,nxTa = get_nxTa(data_,t)
        oxTa= get_oxTa(data_,t)
        xTa = get_xTa(data_,t)
        frame = pd.DataFrame(
        data = {'nxTa':nxTa,'nxTa_start':start,'nxTa_end':end,'indx':indx,'oxTa':oxTa,
                'xTa':xTa
               #'x_start':x,'y_start':y
               }
        )
        lst.append(frame)               
    df = pd.concat(lst)
    df.set_index('indx',drop=True,inplace=True)
    return df