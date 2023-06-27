#for debugging
# readonly branch_name="test_a3api"

# step 1: get release branch name
echo "testing branch name from gitlab is: ${branch_name}"

# step 1: npm pack modules into Bin_repo "server"
echo "================= commence step 1 ================="
# cd ../src
# npm install
# npm pack
# mv ./*.tgz ${branch_name}_nm.tgz
# # should the naming of this node_module packages file be different?
# mv ./${branch_name}_nm.tgz C:/Users/commonuser/Bin_repo
# rm ./package-lock.json
# rm -r ./node_modules

# step 2: move into build_server
# - src code & Dockerfile & .dockerignore
# - .tgz file (node_module packages)
echo "================= commence step 2 ================="

cd ../src
echo "making directory with branch name: ${branch_name}"
mkdir C:/Users/commonuser/build_server/${branch_name}
echo "copying source code in repo/src folder into build_server/${branch_name}"
cp -r ./* C:/Users/commonuser/build_server/${branch_name}
echo "copying node_module tar file from Bin_repo into build_server/${branch_name}"
cp C:/Users/commonuser/Bin_repo/a3api_nm.tgz C:/Users/commonuser/build_server/${branch_name}

# step 3: docker build then run/save
echo "================= commence step 3 ================="
cd C:/Users/commonuser/build_server/${branch_name}
docker build -t ${branch_name} .
# docker run -d --env-file ./config/config.env -p 2424:2424 ${branch_name}
docker save -o ${branch_name}_docker.tar ${branch_name} # &
# save_pid=$!

# step 4: preparing release package to be moved to build_server
echo "================= commence step 4 ================="
mkdir ./${branch_name} #rename this later
cd ./${branch_name}
mkdir ./bin
mkdir ./config
mkdir ./deploy

cp C:/Users/commonuser/build_server/${branch_name}/${branch_name}_docker.tar ./bin
cp -r C:/Users/commonuser/Desktop/a3api/config/*.env ./config
echo "docker load --input ../bin/${branch_name}_docker.tar" >> ./deploy/deploy.sh
echo "docker run -d --name tms_container_${branch_name} --env-file ../config/test_config.env -p 2424:2424 ${branch_name}" >> ./deploy/deploy.sh

# cp C:/Users/commonuser/Desktop/a3api/deploy/deploy.sh ./deploy

cd ..

tar -czvf "${branch_name}.tar.gz" "./${branch_name}"

# pid=$! # Get the process ID (PID) of the previous command
# wait "$pid" # Wait for the previous command to finish executing

mv ./${branch_name}.tar.gz C:/Users/commonuser/Bin_repo

cd ..

rm -r ./${branch_name}

# wait $save_pid
docker rmi ${branch_name}

# create the folder and delete it at the end

# a build_server is a controlled environment to build application