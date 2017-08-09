#! /bin/bash
REDIS="redis-stable"
ZIPPED="$REDIS.tar.gz"
CONF_DIR="/etc/redis"
LOCAL_FILE_DIR="/var/redis"

wget http://download.redis.io/$ZIPPED
tar xvzf $ZIPPED
cd $REDIS
make

mkdir $CONF_DIR
mkdir $LOCAL_FILE_DIR

cp src/redis-server /usr/local/bin/
cp src/redis-cli /usr/local/bin/

cp utils/redis_init_script /etc/init.d/redis_6379
cp redis.conf $CONF_DIR/6379.conf

mkdir $LOCAL_FILE_DIR/6379

cp utils/redis_init_script /etc/init.d/redis-server

sed -i '/daemonize no/c\daemonize yes' $CONF_DIR/6379.conf
sed -i 's:dir ./:\dir /var/redis/6379:' $CONF_DIR/6379.conf

cd ..

rm -r $REDIS

