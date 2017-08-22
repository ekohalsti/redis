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

cp utils/redis_init_script /etc/init.d/redis
cp redis.conf $CONF_DIR/redis.conf

mkdir $LOCAL_FILE_DIR/6379

cp utils/redis_init_script /etc/init.d/redis-server

sed -i '/daemonize no/c\daemonize yes' $CONF_DIR/redis.conf
sed -i 's:dir ./:\dir /var/redis/6379:' $CONF_DIR/redis.conf

update-rc.d redis defaults

cd ..

rm -r $REDIS

/etc/init.d/redis start
