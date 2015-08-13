#!/bin/bash
set -e
source /tmp/build/buildconfig
set -x

#sed -i 's/^\(deb.*\)http:\/\/archive\.ubuntu\.com\(.*\)$/\1http:\/\/ubuntu.stu.edu.tw\2/g' /etc/apt/sources.list
echo "deb http://tw.archive.ubuntu.com/ubuntu/ wily main restricted universe multiverse" > /etc/apt/sources.list
echo "deb-src http://tw.archive.ubuntu.com/ubuntu/ wily main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb http://tw.archive.ubuntu.com/ubuntu/ wily-updates main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb-src http://tw.archive.ubuntu.com/ubuntu/ wily-updates main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb http://tw.archive.ubuntu.com/ubuntu/ wily-security main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb-src http://tw.archive.ubuntu.com/ubuntu/ wily-security main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb http://tw.archive.ubuntu.com/ubuntu/ trusty-backports main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb-src http://tw.archive.ubuntu.com/ubuntu/ trusty-backports main restricted universe multiverse" >> /etc/apt/sources.list
echo 'Acquire::http::Proxy "http://apt.plsm.cs.nccu.edu.tw:3142";' > /etc/apt/apt.conf.d/01aptproxy
apt-get update
apt-get dist-upgrade -y
echo "Asia/Taipei" > /etc/timezone
cp /usr/share/zoneinfo/Asia/Taipei /etc/localtime

$minimal_apt_get_install libaio1
dpkg -i /tmp/build/oci/*.deb
mv /tmp/build/oci/oracle.conf /etc/ld.so.conf.d
ldconfig
mv /tmp/build/oci/oracle.sh /etc/profile.d
ln -s /usr/include/oracle/12.1/client64 /usr/lib/oracle/12.1/client64/include

apt-get autoremove -y
workaround-pam build

apt-get clean
rm -rf /tmp/* /var/tmp/*
rm -rf /var/lib/apt/lists/*
rm -f /etc/ssh/ssh_host_*
