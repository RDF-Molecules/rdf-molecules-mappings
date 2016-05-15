# Dockerfile for data-integration-workspace
# 1) Build an image using this docker file. Run the following docker command
# docker build -t lidakra/silk:latest .
# 2) Run a container with Silk and the configuration files for Fuhsen. Run the following docker command
# docker run -d -p 9005:9005 lidakra/silk:latest

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

RUN sbt info

# Install Sbt
WORKDIR /usr/local/
RUN wget https://dl.bintray.com/sbt/native-packages/sbt/0.13.11/sbt-0.13.11.tgz && \
    tar xvf sbt-0.13.11.tgz

# Install unzip
RUN apt-get install unzip

# Install Silk Master
WORKDIR /home/lidakra/
RUN wget https://github.com/silk-framework/silk/archive/master.zip && \
    unzip master.zip

# Install the mapping file for Silk
COPY Workspace/ mapping/Workspace/ 

# Run Silk with the configuration files for Fuhsen
COPY start_workbench.sh /home/lidakra/silk-master/
WORKDIR /home/lidakra/silk-master/
RUN ["chmod", "u+x", "start_workbench.sh"]
#CMD ./sbt -Dworkspace.provider.file.dir=/home/lidakra/mapping/Workspace -Dhttp.port=9005 "project workbench" run
#CMD ["sh","start_workbench.sh"]
