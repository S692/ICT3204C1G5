import fileinput

fp = r'/root/redis/redis-4.0.0/redis.conf'
with fileinput.FileInput(fp, inplace=True, backup='.bak') as file:
    for line in file:
        print(line.replace('bind 127.0.0.1', '# bind 127.0.0.1'), end='')
with fileinput.FileInput(fp, inplace=True, backup='.bak') as file:
    for line in file:
        print(line.replace('protected-mode yes', 'protected-mode no'), end='')
        
