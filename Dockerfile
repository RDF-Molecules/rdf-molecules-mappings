# Dockerfile for data-integration-workspace
# 1) Build an image using this docker file. Run the following docker command
# docker build -t lidakra/silk:latest .
# 2) Run a container with Silk and the configuration files for Fuhsen. Run the following docker command
# docker run -d -p 9005:9005 -t lidakra/silk:latest

# Pull base image
FROM ubuntu:15.04
MAINTAINER Luigi Selmi <luigiselmi@gmail.com>

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

# Install Silk Framework rel.2.7.1
WORKDIR /home/
RUN wget https://github.com/silk-framework/silk/releases/download/release-2.7.1/silk-workbench-2.7.1.tgz && \
    tar xvf silk-workbench-2.7.1.tgz 
	
# Install the mapping file for Silk
#WORKDIR /home/lidakra
#RUN wget https://github.com/LiDaKrA/data-integration-workspace/releases/download/0.9.1/social_api_mappings.tar.gz && \
#    tar xvf social_api_mappings.tar.gz
COPY Workspace/SocialAPIMappings mapping/ 


# Run Silk with the configuration files for Fuhsen
WORKDIR /home/silk-workbench-2.7.1
CMD ./bin/silk-workbench -Dhttp.port=9005 -Dworkspace.provider.file.dir=/home/lidakra/mapping/SocialAPIMappings

