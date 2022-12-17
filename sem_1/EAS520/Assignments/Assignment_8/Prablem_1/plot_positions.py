import matplotlib.pylab as plt

from utils import get_xy, read_json

OBJ_INITIAL_POS = read_json(file_name='output/obj_initial_position.json')

OBJS_1 = read_json(file_name='output/obj_pos_1.json')
OBJS_2 = read_json(file_name='output/obj_pos_2.json')

OBJ_FINAL_POS = {**OBJS_1, **OBJS_2}


def preprocess_dict(data: dict) -> dict[int, list]:
    data_ = {k: (list(v) if len(v) != 0 else None) for k, v in data.items()}
    data_ = {k: v for k, v in data_.items() if v is not None}
    return data_


OBJ_INITIAL_POS = preprocess_dict(OBJ_INITIAL_POS)
OBJ_FINAL_POS = preprocess_dict(OBJ_FINAL_POS)

OBJ_INITIAL_POS_LIST = sorted(OBJ_INITIAL_POS.items())
OBJ_FINAL_POS_LIST = sorted(OBJ_FINAL_POS.items())

print(OBJ_INITIAL_POS_LIST)
print(OBJ_FINAL_POS_LIST)

fig, ax = plt.subplots(2, figsize=(10, 6))


x1, y1 = get_xy(OBJ_INITIAL_POS_LIST)
x2, y2 = get_xy(OBJ_FINAL_POS_LIST)


ax[0].scatter(x1, y1, color='blue')
ax[0].set_title('Initial Position ')
ax[0].set_xticks(range(0, 12))


ax[1].scatter(x2, y2, color='red')
ax[1].set_title('Final Position ')
ax[1].set_xticks(range(0, 12))


fig.savefig('output/plot.png')
