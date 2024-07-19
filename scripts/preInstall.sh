#install redis tools (used for backup/restore)
apt install -y redis-tools

mkdir -p ./insight
chown -R 1000:1000 ./insight

mkdir -p ./data
chown -R 1001:1001 ./data

export $(xargs <.env)

echo "redis-cli -h $DOMAIN -p  26379 -a $SOFTWARE_PASSWORD" > ./cli.sh;
echo "redis-cli -h $DOMAIN -p  26379 -a $SOFTWARE_PASSWORD save" > ./save.sh;

chmod +x ./cli.sh;
chmod +x ./save.sh;
