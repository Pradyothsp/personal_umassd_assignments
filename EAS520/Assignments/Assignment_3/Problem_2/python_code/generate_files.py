import random
import string
from uuid import uuid4


def get_file_name(path='generated_files/') -> str:
    return path + str(uuid4()) + '.txt'


def char_generator(size=1000, chars=string.ascii_uppercase) -> str:
    return ''.join(random.choice(chars) for _ in range(size))


if __name__ == '__main__':
    for _ in range(100):
        with open(get_file_name(), 'w+') as f:
            f.write(char_generator())
