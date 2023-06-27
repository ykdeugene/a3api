# tar -xzvf "rel_a3api_1.tar.gz" "C:/Users/commonuser/Desktop/Hoo Laptop"

source variable.sh

# ^^^ may not be in deploy.sh ^^^
docker load --input ../bin/rel_a3api_1_docker.tar
docker run -d --name tms_container_rel_a3api_1 --env-file ../config/test_config.env -p 2424:2424 rel_a3api_1

# still needs to take care of scenario where package.json fails during comparison