import glob


def check_palindrome(s, _=None):
    '''
    This function will check if string 's' has palindrome of length 5,
    if so it returns 1 or else it returns 0
    '''
    for i in range(len(s)):
        for j in range(i + 1, len(s) + 1):
            temp = s[i:j]
            # Checking palindrome and if length is 5
            if (temp == temp[::-1]) and (len(temp) == 5):
                return 1
    return 0


def get_all_files(path='generated_files'):
    '''
    This functions returns all the file (extention .txt) inside a folder(path)
    '''
    return [file for file in glob.glob(path + "/*.txt")]


def get_string_from_file(file):
    '''
    This function returns all the text inside a file
    '''
    with open(file, 'r') as f:
        return f.read().rstrip()


if __name__ == '__main__':
    for file in get_all_files():
        print(check_palindrome(get_string_from_file(file=file)))
