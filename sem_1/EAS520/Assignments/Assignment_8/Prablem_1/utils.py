import random
from json import dumps, load


def toss():
    """
    Returns 'Head' or 'Tail'
    """
    return random.choice(['H', 'T'])


def get_temp_dict(objs: dict[int: set]) -> dict[int: set]:
    temp_dict = dict.fromkeys(objs, set())
    print(f"Initial objs: {objs}")

    for k, v in objs.items():
        if len(v) == 0:
            continue

        for val in v:
            flip = toss()  # Will be "H" or "T"

            if flip == 'H':
                if temp_dict.get(int(k + 1)):
                    temp_dict[k + 1] = temp_dict[k + 1].union(set(val))
                else:
                    temp_dict[k + 1] = set(val)

            else:
                if temp_dict.get(k - 1):
                    temp_dict[k - 1] = temp_dict[k - 1].union(set(val))
                else:
                    temp_dict[k - 1] = set(val)

        objs[k] = set()
    print(f"Final Temp: {temp_dict}")

    return temp_dict, objs


def save_json(file_name: str, data: dict[int, set]) -> bool:
    data_list = {k: list(v) for k, v in data.items()}

    json = dumps(data_list)
    f = open(file_name, "w")
    f.write(json)
    f.close()
    return True


def read_json(file_name: str) -> dict[int: set]:
    f = open(file_name)
    data = load(f)

    data = {int(k): set(v) for k, v in data.items()}

    return data
