# Dockerfile for data-integration-workspace
# 1) Build an image using this docker file. Run the following docker command
#     $ docker build -t lidakra/silk:v1.0.0 .
# 2) Run a container with Silk and the configuration files for Fuhsen. Run the following docker command
#     $ docker run -i -t -p 9005:9005 --name silk lidakra/silk:v1.0.0 /bin/bash
# 3) Start the Silk Workbench in the container in background
#     $ ./start_workbench.sh &
# Detach the container using the sequence Ctrl+P Ctrl+Q
# The container can also be started in detach mode executing the command
# $ docker run -d -p 9005:9005 --network=fuhsen-net --name silk lidakra/silk:v1.0.0  

# Pull base image
FROM ubuntu
MAINTAINER Luigi Selmi <luigiselmi@gmail.com>

RUN apt-get update && apt-get -y install locales
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Install Java 8.
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y  software-properties-common && \
    add-apt-repository ppa:webupd8team/java -y && \
    apt-get update && \
    echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections && \
    apt-get install -y oracle-java8-installer && \
    apt-get clean

# Define JAVA_HOME environment variable
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

# Install  network tools (ifconfig, netstat, ping, ip)
RUN apt-get update && \
    apt-get install -y net-tools && \
    apt-get install -y iputils-ping && \
    apt-get install -y iproute2

# Install vi for editing
RUN apt-get update && \
    apt-get install -y vim

# Install Silk-Workbench 
COPY silk-workbench-2.7.2.tgz /home/lidakra/
WORKDIR /home/lidakra/
RUN tar xvf silk-workbench-2.7.2.tgz  

# Copy the mapping file for Fuhsen
COPY Workspace/ mapping/Workspace/ 

# Install the script to run Silk Workbench with the mapping  files
COPY start_workbench.sh /home/lidakra/silk-workbench-2.7.2/
WORKDIR /home/lidakra/silk-workbench-2.7.2/
RUN ["chmod", "u+x", "start_workbench.sh"]

CMD ./start_workbench.sh 
