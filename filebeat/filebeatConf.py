with open('/etc/filebeat/filebeat.yml', 'r') as file:
    data = file.read()

data = data.replace('- type: filestream', '- type: log')
data = data.replace('enabled: false', 'enabled: true')
data = data.replace('- /var/log/*.log', '- /var/log/alternatives.log\n    - /var/log/dpkg.log\n    - /var/log/user.log\n    - /var/log/mail.log\n    - /var/log/cron.log\n    - /var/log/bootstrap.log\n    - /var/log/faillog\n    - /var/log/lastlog\n    - /var/log/tallylog    - /var/log/apt/history.log\n    - /var/log/lastlog')
data = data.replace('id: my-filestream-id', '# id: my-filestream-id')
data = data.replace('#setup.dashboards.enabled: false', 'setup.dashboards.enabled: true')
data = data.replace('#host: "localhost:5601"', 'host: "172.18.0.4:5601"')
data = data.replace('hosts: ["localhost:9200"]', 'hosts: ["172.18.0.4:9200"]')


with open('/etc/filebeat/filebeat.yml', 'w') as file:
    file.write(data)
