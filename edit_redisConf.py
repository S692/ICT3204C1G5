#!/usr/bin/env python3

# rmb to chmod 777 and run as ./filename.py
with open('/root/redis/redis-4.0.0/redis.conf', 'r') as file:
    data = file.read()

data = data.replace('bind 127.0.0.1', '# bind 127.0.0.1')
data = data.replace('protected-mode yes', 'protected-mode no')

with open('/root/redis/redis-4.0.0/redis.conf', 'w') as file:
    file.write(data)
