import random
from utils import save_json

N = 10  # Number of grid points
OBJ = ['A', 'B', 'C', 'D', 'E', 'F']

FINAL_POS = dict()

# Creating dict of size N (from 1 to N+1) to store positions
OBJ_POS = {i: set() for i in range(1, N + 1)}


def init_pos(obj_: str) -> bool:
    pos_ = random.choice(range(1, N + 1))
    OBJ_POS[pos_] = OBJ_POS[pos_].union(set(obj_))
    return True


# Initializing OBJ positions
_ = [init_pos(obj_=obj) for obj in OBJ]

print(f"original {OBJ_POS}")

# Dividing OBJ_POS into 2 dict for 2 cores
OBJS_1 = dict()
OBJS_2 = dict()

_ = [OBJS_1.update({key: value}) if key <= N / 2 else OBJS_2.update({key: value}) for key, value in OBJ_POS.items()]

save_json(file_name='objs_1_init.json', data=OBJS_1)
save_json(file_name='objs_2_init.json', data=OBJS_2)
