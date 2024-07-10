#set env vars
set -o allexport; source .env; set +o allexport;

#wait until the server is ready
echo "Waiting for redis insight to be ready ..."
sleep 10s;

#install redis tools for cli helper
apt install -y redis-tools

#register the local server in the web ui
redis_insight_target=$(docker-compose port redisinsight 8001)
curl --output /dev/null --header "Content-Type: application/json" \
 --request POST --data '{ "name": "local", "connectionType": "STANDALONE", "host": "redis","port": 6379,"password": "'"$SOFTWARE_PASSWORD"'"}' \
 http://$redis_insight_target/api/instance/


sleep 25s;
docker-compose down
sudo apt-get install openssl -y
openssl genrsa -out ./data/redis.key 2048
openssl req -new -key ./data/redis.key -out ./data/redis.csr -subj "/CN=${DOMAIN}"
openssl x509 -req -days 3650 -in ./data/redis.csr -signkey ./data/redis.key -out ./data/redis.crt
cp ./data/redis.crt ./data/ca.crt 
sleep 5s;
sed -i 's/#--tls/--tls/' docker-compose.yml
docker-compose up -d;