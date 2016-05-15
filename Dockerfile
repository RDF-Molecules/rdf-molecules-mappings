# Dockerfile for data-integration-workspace
# 1) Build an image using this docker file. Run the following docker command
# $ docker build -t lidakra/silk:latest .
# 2) Run a container with Silk and the configuration files for Fuhsen. Run the following docker command
# $ docker run -d -p 9005:9005 lidakra/silk:latest
# 3) Start the Silk Workbench in the container
# $ docker exec -d <container> ./start_workbench.sh
# where <container> is a place holder for the container name or id.

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

# Install jai_core.jar
WORKDIR /home/lidakra/
COPY lib/jai_core-1.1.3.jar $JAVA_HOME/jre/lib/ext/ 

# Install curl
RUN apt-get -qq -y install curl

ENV SCALA_VERSION 2.11.7 
ENV SBT_VERSION 0.13.11 

# Install Scala 
## Piping curl directly in tar 
RUN \
  curl -fsL http://downloads.typesafe.com/scala/$SCALA_VERSION/scala-$SCALA_VERSION.tgz | tar xfz - -C /root/ && \
  echo >> /root/.bashrc && \
  echo 'export PATH=~/scala-$SCALA_VERSION/bin:$PATH' >> /root/.bashrc

# Install sbt 
RUN \
  curl -L -o sbt-$SBT_VERSION.deb http://dl.bintray.com/sbt/debian/sbt-$SBT_VERSION.deb && \
  dpkg -i sbt-$SBT_VERSION.deb && \
  rm sbt-$SBT_VERSION.deb && \
  apt-get update && \
  apt-get install sbt

# Download Sbt dependencies
RUN sbt info

# Install unzip
RUN apt-get install unzip

# Install Silk Master
WORKDIR /home/lidakra/
RUN wget https://github.com/silk-framework/silk/archive/master.zip && \
    unzip master.zip

# Install jai_core.jar to compile Silk (not available from repository)
#COPY lib/jai_core-1.1.3.jar $JAVA_HOME/jre/lib/ext/ 


# Copy the mapping file for Fuhsen
COPY Workspace/ mapping/Workspace/ 

# Install the script to run Silk Workbench with the mapping  files
COPY start_workbench.sh /home/lidakra/silk-master/
WORKDIR /home/lidakra/silk-master/
RUN ["chmod", "u+x", "start_workbench.sh"]

# Compile Silk Workbench
RUN sbt compile

#CMD ./start_workbench
