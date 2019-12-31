# DOCKER 

##

Docker client ---> cli shell which runs commands that are sent to the docker daemon

Docker daemon ---> local docker process

Docker image  ---> file containing data that is used to create an OS and apps

``` docker run <imagename> ```

``` 
$ docker run hello-world

Unable to find image 'hello-world:latest' locally
latest: Pulling from library/hello-world
1b930d010525: Pull complete
Digest: sha256:2557e3c07ed1e38f26e389462d03ed943586f744621577a99efb77324b0fe535
Status: Downloaded newer image for hello-world:latest

Hello from Docker!
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
    (amd64)
 3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
 4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.

To try something more ambitious, you can run an Ubuntu container with:
 $ docker run -it ubuntu bash

Share images, automate workflows, and more with a free Docker ID:
 https://hub.docker.com/

For more examples and ideas, visit:
 https://docs.docker.com/get-started/
 ```
 ---


Life Cycle of a Container

docker run = docker create + docker start

Stopping a container
-  docker stop container id
   -  SIGTERM is sent to container to shutdown on its own time.
      - a graceful shutdown, gives time to shut things down and do a little clean up
   -  Ideally use this command to stop containers
-  docker kill container id
   -  SIGKILL or kill signal. You have to shut down right now. Dirty shutdown
   -  Use this to stop a container that wont shut down. Stop reverts to kill after 10 seconds

docker run options
*   -i ---> interactive, attach our terminal to STDIN 
*   -t ---> ensures text shows up in a nicely formatted manner
*   -d (--detach) ---> detach, container runs in the background.
*   -p 80:80 ---> port mapping. port_outside_container:port_inside_container. ports do not have to be identicial.


docker logs
*  docker logs [OPTIONS] CONTAINER
*  docker-compose logs [OPTIONS] [SERVICE...]

docker add vs copy

-  ADD can use URLS (not recommended, use curl or wget) and can uncompress tar and zips

-  COPY just copies

USER

sets the user

WORKDIR sets the working directory and any instructions set after the WORKDIR will be ran from that dir

---

To build an image:
1. first pick the right image
2. run the image with a shell and build the environment inside the container. 
3. Add the steps you used to build the environment to your docker file.
4. Repeat Steps 2 & 3

Picking the right image:


---
## Dockerfile

Minimize the amount of steps

Structure the Dockerfile with the static and least likely to change code at the top and put anything that could be changed and updated at the bottom of the file.
- This ensures that cached images are used to as much as possible to decrease build time

Dockerfile always starts with the base image, FROM alpine:latest

Dangling images ---> original image that is left behind after the Dockerfile has been updated and rebuilt. Takes up space on HDD.
- docker images --filter "dangling=true"
- docker rmi $(docker images -q --filter "dangling=true") ---> 
   - -q removes headings from docker output (stdout)


---
docker is fun
docker is a container managment and set up --- [please expand on this]

docker ps - lists running containers
docker ps -a - lists all containers
docker run - starts a container from an image
   docker run [options] container


run a command in an existing (running) container 
   - docker exec

---
### Docker Compose

Manage multiple containers. Easier to manage and use commands that are usually used with docker run. 

docker-compose.yml

```
# Declare the version of docker-compose that will be used
version: '3'

# Services is similar to a container. Defining services (containers) with the specifications listed
services:
   # name of the container (services)
   redis-server:
      # image to be used for this container (service)
      image: 'redis'
   # second service that will be created
   # name of service (container)
   node-app:
      # look in the current directory for a Dockerfile and use that to build the image used for this container
      build: .
      # specify the ports to be opened
      ports:
         # a dash in YAML is used to specifiy an array. localmachine_port:container_port
         - "8081:8081"
```

Dockerfile to go along with this docker-compose.yml:
```
FROM node:alpine
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
CMD ["npm", "start"]
```

another example
```
version: '3'
services:
  web:
    build:
      context: .
      dockerfile: Dockerfile.dev
    ports:
      - "3000:3000"
    volumes:
      - /app/node_modules
      - .:/app
```

#### Now start docker compose using this file.

- docker run image = docker-compose up.
   - looks in currently directory for a docker compose file
   - automatically creates a network and allows different containers to communicate with each other.
- docker build . & docker run image = docker-compose up --build

#### Stopping docker compose containers

docker-cli:
- docker run -d redis ---> runs the container and detaches from it so it runs in the background

docker-compose:
- docker-compose up -d ---> launches container(s) in the background
- docker-compose down ---> shut

#### Dealing with a crashed container
- Restart policies

| Policy | Explanation
|---|---
| "no"   |  never attempt to restart container if it stops or crashes. no requires quotes, default yaml inteprets no as false.
| always | if the container stops for any reason always attempt to restart it
| on-failure | only restart if the container stops with an error code
| unless-stopped | always restart unless we (ops) force stop it

to add a restart policy to your docker-compose.yml, add the following line to a services:
 - restart: always 
 ```
 $ cat docker-compose.yml
version: '3'
services:
    redis-server:
        image: 'redis'
    node-app:
        restart: always
        build: .
        ports:
          - "4081:8081"
  ```




docker run -d \
-v data:/var/www/html/data \
nextcloud




#### -v or --mount

--mount is simpler(?) than --volume 

mount consists of key value pairs 
volume fields are separated by colon characters - there are 3 fields and they must be in the correct order.
   - if the volume has a name, the name field is the first field. if the volume has no name, the name field is omitted
   - the second field is the path where the file or dir are mounted in the container. 
   - the third field is optional and is a comma,separated list of options, ie ro or rw




---

Github repo

2 branches
1. feature 
2. master 

pull latest code from feature branch to dev laptop

only pull/push code to feature branch.

push any changes you make back to feature branch. never push code directly to master.

A **pull request** will be made to merge any changes you made to the feature branch over to the master branch.
- pull request will automatically take master branch and 



