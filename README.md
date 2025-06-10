# Установка и настройка OpenVPN и Iptables


## Установка OpenVPN при помощи скрипта "angristan"

Загрузка и установка OpenVPN
```bash
curl -O https://raw.githubusercontent.com/angristan/openvpn-install/master/openvpn-install.sh
```

Запустите скрипт и следуйте инстркукциям (можете смело соглашаться с вариантами скрипта)
```bash
sudo bash openvpn-install.sh
```

После отработки скрипта, вы получите файл с расширением *.ovpn* который необходимо будет скопировать на свой ПК, Mac <br>
MacOS, Linux:
```bash
scp [логин]@[IP-адрес_сервера]:[путь/к/файлу.ovpn] [куда/сохранить/на/компьютер] # scp server@15.89.17.140:/home/myserver/myvpn.ovpn ~/Desktop/
```
Windows:
```bash
scp [логин]@[IP-адрес_сервера]:[путь/к/файлу.ovpn] [Диск:\куда\сохранить\] # scp server@15.89.17.140:/home/tt/droff.ovpn C:\Users\ВАШЕ_ИМЯ_ПОЛЬЗОВАТЕЛЯ\Desktop\
```
<br>

> Также можно просто скопировать содержимое файла в буфер обмена, создать файл с расирением .ovpn на вашем компьютере,
> вставить в него содержимое буфера обмена и сохранить 

Для того, чтобы просмотреть содержимое файла .ovpn на сервере, выполните команду:
```bash
cat name.ovpn # Где "name" должно быть замененно на имя вышего файла
```

---

## Установка и настройка Iptables

Scpripts to help easy clean/setup your nodes's database using StateSync
## Juno
Run following comand in your node's server terminal
```
curl https://raw.githubusercontent.com/Dr0ff/Useful-scripts/refs/heads/main/juno_stat_sync.sh | bash
```
## Sommelier
Run following comand in your node's server terminal
```
curl https://raw.githubusercontent.com/Dr0ff/Useful-scripts/refs/heads/main/sommelier_stat_sync_.sh | bash
```
## Lava
Run following comand in your node's server terminal
```
curl https://raw.githubusercontent.com/Dr0ff/Useful-scripts/refs/heads/main/lava_st_sync.sh | bash
```




-------------------------
 ```Validator Configuration Script``` !!!Not yet ready!!!
    <p>A simple Bash script helps to setup validator nodes. 
    Helps you with blockchain validator's node configurations: verifies the existence of required directories and configuration files, adjusts pruning and indexer settings for optimized performance, and dynamically updates network ports to support multiple instances of the service. The script also provides user-friendly prompts to guide through enabling pruning, selecting service instances, and updating configurations with detailed validation at every step."
    </p>

Download to your /home/USER/:<br/>
[presetup.sh](https://raw.githubusercontent.com/Dr0ff/Useful-scripts/refs/heads/main/presetup.sh) or
```shell
wget -k -c -q -L https://raw.githubusercontent.com/Dr0ff/Useful-scripts/refs/heads/main/presetup.sh
```
<br/>
To run it <br/>

```bash presetup.sh```


