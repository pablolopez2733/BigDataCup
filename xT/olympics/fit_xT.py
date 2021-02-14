import os
import sys
import pandas as pd
module_path = os.path.abspath(os.path.join('..'))
if module_path not in sys.path:
    sys.path.append(module_path)
from xT import *

data=pd.read_csv('data.csv')
xTModel = ExpectedThreat(l=16, w=12)
xTModel.fit(data)

mov_actions = get_successful_move_actions(data)
mov_actions["xTa"] = xTModel.predict(mov_actions)
xt_dic=mov_actions.xTa.to_dict()
data['xTa']=data.index.map(xt_dic)
data.to_csv('xt_table.csv',index=False)

interp = xTModel.interpolator()
x = np.linspace(0, 200, 2000)
y = np.linspace(0, 85, 850)

matrix = interp(x,y)
frame = pd.DataFrame(matrix)

m_lst = []
n_lst = []
p_lst = []
for m in frame.columns:
    for n in frame.index:
        p_lst.append(frame[m][n])
        m_lst.append(m)
        n_lst.append(n)
export=pd.DataFrame(data={'x':m_lst,'y':n_lst,'xt':p_lst})
export.to_csv('frame_plot.csv',index=False)
