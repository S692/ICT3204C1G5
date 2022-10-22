with open('/etc/rsyslog.d/50-default.conf', 'r') as file:
    data = file.read()

data = data.replace('#cron.*', 'cron.*')
data = data.replace('#user.*', 'user.*')
data = data.replace('#mail.info', 'mail.info')

with open('/etc/rsyslog.d/50-default.conf', 'w') as file:
    file.write(data)
