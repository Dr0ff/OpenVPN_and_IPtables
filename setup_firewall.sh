#!/bin/bash

# =================================================================
# Безопасный скрипт настройки IPTABLES для сервера с нодой и OpenVPN
# =================================================================

# --- КОНФИГУРАЦИЯ ---
# ВНИМАТЕЛЬНО ИЗМЕНИТЕ ЭТИ ПАРАМЕТРЫ ПЕРЕД ЗАПУСКОМ!

# Имя вашего основного сетевого интерфейса, который смотрит в интернет (узнать командой `ip a`)
PUBLIC_IF="ens3"

# Ваш порт SSH. Если вы его не меняли, то это 22.
SSH_PORT="22"

# Порт и протокол для OpenVPN
VPN_PORT="1194"
VPN_PROTO="udp"
VPN_IF="tun0" # Обычно tun0 для первого OpenVPN-сервера
VPN_SUBNET="10.8.0.0/24" # Укажите точную подсеть вашего VPN

# P2P порт ноды Cosmos (Sommelier). Стандартный - 26656.
P2P_PORT="26656"

# --- НАЧАЛО СКРИПТА ---

echo ">>> Установка iptables-persistent для сохранения правил..."
apt-get update
apt-get install -y iptables-persistent

echo ">>> Очистка всех существующих правил и цепочек..."
iptables -F # Flush all rules
iptables -X # Delete all user-defined chains
iptables -t nat -F
iptables -t nat -X
iptables -t mangle -F
iptables -t mangle -X
iptables -Z # Zero all packet and byte counters

echo ">>> Установка политики 'запретить по умолчанию' (Default Drop)..."
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT # Разрешаем все исходящие соединения (необходимо для работы ноды и системы)

echo ">>> Настройка базовых разрешающих правил..."
# Разрешаем трафик на loopback-интерфейсе (важно для работы многих служб)
iptables -A INPUT -i lo -j ACCEPT

# Разрешаем уже установленные и связанные соединения (самое важное правило!)
iptables -A INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT

echo ">>> Разрешение необходимых входящих соединений..."
# Разрешаем SSH
iptables -A INPUT -p tcp --dport $SSH_PORT -j ACCEPT

# Разрешаем OpenVPN
iptables -A INPUT -i $PUBLIC_IF -p $VPN_PROTO --dport $VPN_PORT -j ACCEPT

# Разрешаем P2P для ноды Cosmos
iptables -A INPUT -p tcp --dport $P2P_PORT -j ACCEPT

echo ">>> Настройка правил для OpenVPN (Forwarding и NAT)..."
# Разрешаем трафик от клиентов VPN к самому серверу
iptables -A INPUT -i $VPN_IF -j ACCEPT

# Разрешаем пересылку пакетов из VPN в интернет
iptables -A FORWARD -i $VPN_IF -o $PUBLIC_IF -j ACCEPT

# Включаем NAT (Masquerading) для VPN-подсети
iptables -t nat -A POSTROUTING -s $VPN_SUBNET -o $PUBLIC_IF -j MASQUERADE

echo ">>> Сохранение настроенных правил..."
netfilter-persistent save

echo ">>> Готово! Правила файрвола успешно применены и сохранены."
