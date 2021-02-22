#Load modules
import pandas as pd
from typing import Callable, List, Tuple
import numpy as np
from pandera.typing import DataFrame, Series
try:
    from scipy.interpolate import interp2d
except ImportError:
    interp2d = None
M: int = 8
N: int = 16

def _get_cell_indexes(x: Series, y: Series, l: int = N, w: int = M) -> Tuple[Series, Series]:
    xmin = 0
    ymin = 0
    xi = (x - xmin) / 200 * l
    yj = (y - ymin) / 85 * w
    xi = xi.astype(int).clip(0, l - 1)
    yj = yj.astype(int).clip(0, w - 1)
    return xi, yj

def _get_flat_indexes(x: Series, y: Series, l: int = N, w: int = M) -> Series:
    xi, yj = _get_cell_indexes(x, y, l, w)
    return l * (w - 1 - yj) + xi

def _count(x: Series, y: Series, l: int = N, w: int = M) -> np.ndarray:
    x = x[~np.isnan(x) & ~np.isnan(y)]
    y = y[~np.isnan(x) & ~np.isnan(y)]
    flat_indexes = _get_flat_indexes(x, y, l, w)
    vc = flat_indexes.value_counts(sort=False)
    vector = np.zeros(w * l)
    vector[vc.index] = vc
    return vector.reshape((w, l))

def _safe_divide(a: np.ndarray, b: np.ndarray) -> np.ndarray:
    return np.divide(a, b, out=np.zeros_like(a), where=b != 0)

def scoring_prob(actions, l: int = N, w: int = M) -> np.ndarray:
    actions=actions[actions['success'].isna() == False]
    actions=actions[actions['end_x'].isna() == False]
    shot_actions = actions[(actions.type_name == 'Shot')]
    goals = shot_actions[(shot_actions.success == 1.0)]

    shotmatrix = _count(shot_actions.start_x, shot_actions.start_y, l, w)
    goalmatrix = _count(goals.start_x, goals.start_y, l, w)
    return _safe_divide(goalmatrix, shotmatrix)

def scoring_prob_augmented(t):
    if t == 1:
        df1 = pd.read_csv(
            "../modules/score_prob_matrices/score_t1.csv",
        header=None)
        return df1.values
    if t == 2:
        df2 = pd.read_csv(
            "../modules/score_prob_matrices/score_t2.csv",
        header=None)
        return df2.values
    if t == 3:
        df3 = pd.read_csv(
            "../modules/score_prob_matrices/score_t3.csv",
        header=None)
        return df3.values
    if t == 4:
        df4 = pd.read_csv(
            "../modules/score_prob_matrices/score_t4.csv",
        header=None)
        return df4.values
    
def get_move_actions(actions):
    actions=actions[actions['success'].isna() == False]
    actions=actions[actions['end_x'].isna() == False]
    return actions[
        (actions.type_name == 'Zone Entry')
        | (actions.type_name == 'Pass')
        #| (actions.type_name == 'Faceoff')
    ]

def get_successful_move_actions(actions):
    actions=actions[actions['success'].isna() == False]
    actions=actions[actions['end_x'].isna() == False]
    move_actions = get_move_actions(actions)
    return move_actions[move_actions.success == 1.0]

def action_prob(
    actions, l: int = N, w: int = M
) -> Tuple[np.ndarray, np.ndarray]:
    actions=actions[actions['success'].isna() == False]
    actions=actions[actions['end_x'].isna() == False]
    move_actions = get_move_actions(actions)
    shot_actions = actions[(actions.type_name == 'Shot')]

    movematrix = _count(move_actions.start_x, move_actions.start_y, l, w)
    shotmatrix = _count(shot_actions.start_x, shot_actions.start_y, l, w)
    totalmatrix = movematrix + shotmatrix

    return _safe_divide(shotmatrix, totalmatrix), _safe_divide(movematrix, totalmatrix)

def move_transition_matrix(actions, l: int = N, w: int = M) -> np.ndarray:
    actions=actions[actions['success'].isna() == False]
    actions=actions[actions['end_x'].isna() == False]
    move_actions = get_move_actions(actions)

    X = pd.DataFrame()
    X['start_cell'] = _get_flat_indexes(move_actions.start_x, move_actions.start_y, l, w)
    X['end_cell'] = _get_flat_indexes(move_actions.end_x, move_actions.end_y, l, w)
    X['success'] = move_actions.success

    vc = X.start_cell.value_counts(sort=False)
    start_counts = np.zeros(w * l)
    start_counts[vc.index] = vc

    transition_matrix = np.zeros((w * l, w * l))

    for i in range(0, w * l):
        vc2 = X[((X.start_cell == i) & (X.success == 1.0))].end_cell.value_counts(
            sort=False
        )
        transition_matrix[i, vc2.index] = vc2 / start_counts[i]

    return transition_matrix

class ExpectedThreat:
    def __init__(self, l: int = N, w: int = M, eps: float = 1e-5):
        self.l = l
        self.w = w
        self.eps = eps
        self.heatmaps: List[np.ndarray] = []
        self.xT: np.ndarray = np.zeros((w, l))
        self.scoring_prob_matrix: np.ndarray = np.zeros((w, l))
        self.shot_prob_matrix: np.ndarray = np.zeros((w, l))
        self.move_prob_matrix: np.ndarray = np.zeros((w, l))
        self.transition_matrix: np.ndarray = np.zeros((w * l, w * l))
    def __solve(
        self,
        p_scoring: np.ndarray,
        p_shot: np.ndarray,
        p_move: np.ndarray,
        transition_matrix: np.ndarray,
    ) -> None:
        gs = p_scoring * p_shot
        diff = 1
        it = 0
        self.heatmaps.append(self.xT.copy())

        while np.any(diff > self.eps):
            total_payoff = np.zeros((self.w, self.l))

            for y in range(0, self.w):
                for x in range(0, self.l):
                    for q in range(0, self.w):
                        for z in range(0, self.l):
                            total_payoff[y, x] += (
                                transition_matrix[self.l * y + x, self.l * q + z] * self.xT[q, z]
                            )

            newxT = gs + (p_move * total_payoff)
            diff = newxT - self.xT
            self.xT = newxT
            self.heatmaps.append(self.xT.copy())
            it += 1

        print('# iterations: ', it)

    def fit(self, actions,t) -> 'ExpectedThreat':
        self.scoring_prob_matrix = scoring_prob_augmented(t)
        self.shot_prob_matrix, self.move_prob_matrix = action_prob(actions, self.l, self.w)
        self.transition_matrix = move_transition_matrix(actions, self.l, self.w)
        self.__solve(
            self.scoring_prob_matrix,
            self.shot_prob_matrix,
            self.move_prob_matrix,
            self.transition_matrix,
        )
        return self

    def interpolator(self, kind: str = 'linear') -> Callable[[np.ndarray, np.ndarray], np.ndarray]:
        if interp2d is None:
            raise ImportError('Interpolation requires scipy to be installed.')

        cell_length = 200 / self.l
        cell_width = 85 / self.w

        x = np.arange(0.0, 200, cell_length) + 0.5 * cell_length
        y = np.arange(0.0, 85, cell_width) + 0.5 * cell_width

        return interp2d(x=x, y=y, z=self.xT, kind=kind, bounds_error=False)
    
    def get_xT(self, actions) -> np.array:
        l = self.l
        w = self.w
        grid = self.xT
        startxc, startyc = _get_cell_indexes(actions.start_x, actions.start_y, l, w)
        endxc, endyc = _get_cell_indexes(actions.end_x, actions.end_y, l, w)
        xT_start = grid[w - 1 - startyc, startxc]
        xT_end = grid[w - 1 - endyc, endxc]
        return xT_start , xT_end
    
    def predict(
        self, actions, use_interpolation: bool = False
    ) -> np.ndarray:
        if not use_interpolation:
            l = self.l
            w = self.w
            grid = self.xT
        else:
            # Use interpolation to create a
            # more fine-grained 1050 x 680 grid
            interp = self.interpolator()
            l = int(200 * 10)
            w = int(85 * 10)
            xs = np.linspace(0, 200, l)
            ys = np.linspace(0, 85, w)
            grid = interp(xs, ys)

        startxc, startyc = _get_cell_indexes(actions.start_x, actions.start_y, l, w)
        endxc, endyc = _get_cell_indexes(actions.end_x, actions.end_y, l, w)

        xT_start = grid[w - 1 - startyc, startxc]
        xT_end = grid[w - 1 - endyc, endxc]

        return xT_end - xT_start
    
    def nxT() -> np.array:
        grid = self.xT
        return grid
    
def return_xTa_values(actions) -> np.ndarray:
    x = actions.start_x
    y = actions.start_y
    l=16
    w=8
    lst = []
    xTModel = ExpectedThreat(l, w)
    for t in range(1,5):    
        data_=actions[actions['time'] == t].copy()
        x=data_.start_x
        y=data_.start_y
        indx = data_.index
        xTModel.fit(data_,t)
        xTa = xTModel.predict(data_)
        start,end = xTModel.get_xT(data_)
        frame = pd.DataFrame(
        data = {'xTa':xTa,'xTa_start':start,'xTa_end':end,'indx':indx,
               'x_start':x,'y_start':y})
        lst.append(frame)               
    df = pd.concat(lst)
    df.set_index('indx',drop=True,inplace=True)
    return df