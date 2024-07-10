source .env
#Getting running port and IP
redis_target=$(docker-compose port redis 6379)

#Running port
redis_target_ip=`echo $redis_target | cut -d ':' -f 1`

#Running ip
redis_target_port=`echo $redis_target | cut -d ':' -f 2`

#save latest dump to disk
redis-cli -h $redis_target_ip -p $redis_target_port -a $SOFTWARE_PASSWORD save
