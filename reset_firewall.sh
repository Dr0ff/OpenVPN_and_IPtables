#!/bin/bash

# =================================================================
# Скрипт для ПОЛНОГО СБРОСА правил IPTABLES
# ВНИМАНИЕ: Этот скрипт делает сервер полностью открытым!
# =================================================================

echo ">>> Очистка всех существующих правил, цепочек и таблиц..."
iptables -F # Flush all rules
iptables -X # Delete all user-defined chains
iptables -t nat -F
iptables -t nat -X
iptables -t mangle -F
iptables -t mangle -X
iptables -Z # Zero all packet and byte counters

echo ">>> Установка политики 'разрешить всё' по умолчанию (ACCEPT)..."
iptables -P INPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT

echo ">>> Сохранение пустой конфигурации..."
# Это перезапишет сохраненные правила пустыми, чтобы после перезагрузки файрвол оставался открытым
netfilter-persistent save

echo ">>> Готово! Файрвол полностью сброшен. Все соединения разрешены."
# sudo apt-get purge iptables-persistent -y
