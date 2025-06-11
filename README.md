
# Установка и настройка OpenVPN и Iptables


## ➡️ Установка OpenVPN при помощи скрипта "angristan"

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

## ➡️ Установка и настройка Iptables

 Скрипт который установит и настроит основные правила фаервол для сервера

Скачиваем скрипт:
```
wget https://raw.githubusercontent.com/Dr0ff/OpenVPN_and_IPtables/refs/heads/main/setup_firewall.sh
```

 Откроем, проверим и отредактируем скрипт *если нужно изменить параметры портов:
```
nano setup_firewall.sh
```

 Запускаем скрипт:
```
sudo bash setup_firewall.sh
```

---


## ➡️ Запуск сервера OpenVPN и настройка альясов

 Команда запуска сервера OpenVPN и включение автозагрузки:

```
sudo systemctl restart openvpn@server.service && sudo systemctl enable openvpn.service
```

 Команда остановки сервера OpenVPN и выключение автозагрузки:

```
sudo systemctl stop openvpn@server.service && sudo systemctl disable openvpn.service
```

### Сделаем простые команды для включения/отключения

 Добавим альясы *vpnon* и *vpnoff* для включения и выключения сервера OpenVPN
```
echo "alias vpnon='sudo systemctl start openvpn@server.service && sudo systemctl enable openvpn.service'" >> ~/.bashrc
echo "alias vpnoff='sudo systemctl stop openvpn@server.service && sudo systemctl disable openvpn.service'" >> ~/.bashrc
```

 Применим изменения:

```
source .bashrc
```

 Проверка статуса сервиса

```
sudo systemctl status openvpn@server.service -l --no-pager
```

---

## ➡️ Запуск соединения на клиентской машине

 Консольная версия:
 
На unix машинах (Linux, MacOS), OpenVPN как правило уже установлен <br>
Запустите команду:

```
sudo openvpn --config name.ovpn # Где "name.ovpn" название именно вашего файла
```

### GUI Клиенты OpenVPN

 Для Windows:

<li>OpenVPN GUI</li>
 
Где взять: [openvpn.net/community-downloads/](https://openvpn.net/community-downloads/) (обычно поставляется вместе с "OpenVPN installer for Windows").<br>
После установки он живет в системном трее (возле часов), вы просто кликаете правой кнопкой мыши по иконке, выбираете свой профиль и нажимаете "Подключиться".
Это самый проверенный временем вариант.

<li>OpenVPN Connect (Официальный, более современный интерфейс)</li>

Где взять: [https://openvpn.net/client/](https://openvpn.net/client/)<br>
 У него более современный и дружелюбный интерфейс по сравнению с классическим OpenVPN GUI. 
 Он также полностью совместим и надежен.


 Для Mac OS:

<li>Tunnelblick (Бесплатный, Open-Source, Рекомендуется)</li>

Где взять: [tunnelblick.net](https://tunnelblick.net/)<br>
Почему он лучший: Tunnelblick — это стандарт де-факто для OpenVPN на Mac. 
Он бесплатный, с открытым исходным кодом, очень надежный и простой. 
Вы просто дважды кликаете по вашему .ovpn файлу, и он автоматически импортирует все настройки. 
Управлять подключением можно через иконку в верхней строке меню.


<li>OpenVPN Connect (Официальный клиент)

Где взять: App Store или сайт OpenVPN.<br>
Это официальный клиент от OpenVPN Inc. 
Он простой, надежный и хорошо работает. 
Исторически он был больше ориентирован на коммерческие продукты OpenVPN, но отлично работает и с обычными серверами.</li>

 Для Linux (Desktop, например Ubuntu)

<li>Встроенный Network Manager (Самый интегрированный способ)</li>

Как использовать: В большинстве дистрибутивов Linux (Ubuntu, Fedora) есть встроенный менеджер сетевых подключений. <br>
Вы можете установить для него плагин OpenVPN.
```
sudo apt-get install network-manager-openvpn-gnome
```
После установки вы можете зайти в "Настройки" -> "Сеть" -> "VPN", нажать "+" и выбрать "Импортировать из файла", <br>
указав ваш .ovpn файл. <br>

Соединением можно будет управлять прямо из системного меню, как Wi-Fi.
