#!/bin/bash

# Herhangi bir komut başarısız olursa betiğin çalışmasını durdurur.
set -e

echo "--- Konteyner içi kurulum başlıyor ---"
apt-get update -y
apt-get install -y ros-humble-mavros ros-humble-mavros-msgs python3-colcon-common-extensions

echo "--- ROS 2 ortamı ayarlanıyor ---"
# Konteyner içinde olduğumuz için source komutunu burada kullanıyoruz.
source /opt/ros/humble/setup.bash

# Betiğin çalıştığı dizinden proje kök dizinine geçiyoruz.
# Proje kök dizini /root/ws olarak bağlanmıştı.
cd /root/ws

echo "--- ROS 2 bağımlılıkları çözülüyor ---"
rosdep install -i --from-path src --rosdistro humble -y --skip-keys "mavros"

echo "--- Çalışma alanı derleniyor ---"
colcon build

echo "--- Derleme başarıyla tamamlandı! ---"
