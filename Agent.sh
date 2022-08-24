#!/bin/bash
cd /jekyll

echo '啓動配置 ..'
#下載程式 --------------------------------------------------------------
cd /jekyll

echo '獲取資源 ..'

git clone https://github.com/Jekyll-Mask-repo/Paas-Bin.git
git clone https://github.com/Jekyll-Mask-repo/Jekyll-config.git

echo '調整文件結構.'

chmod 0777 -R Paas-Bin
mv Paas-Bin/* /jekyll/
chmod 0777 -R Jekyll-config
mv Jekyll-config/* /jekyll/
rm -rf Paas-Bin Jekyll-config

echo '前期準備..'
mkdir /.temp
mkdir /.temp/tunnel
mkdir /.temp/tunnel/id/
mkdir /.temp/tunnel/id/.86de6451-e653-4318-bd38-4e8e4a9d8006
#啓動-------------------------------------------------------------------
cd /jekyll

echo '正在啓動 ..'
sleep 2

./jekyll-tunnel service install `cat Config/tunnel-ID` > /dev/null &

./jekyll run -c jekyll.yaml > /dev/null &

./caddy run --config Caddyfile
# ----------------------------------------------------------------------
echo ‘完成’
