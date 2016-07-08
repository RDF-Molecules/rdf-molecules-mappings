# SILK data integration workspace

This project contains mapping and linking tasks executed with Silk Link Discovery Framework
General information about Silk can be found on the official [website](http://silkframework.org).

### Package the Silk Workbench
Download SILK framework https://github.com/silk-framework/silk and compile the Silk Workbench executing the command

    $ sbt "project workbench" universal:package-zip-tarball

A zipped tar file, silk-workbench-2.7.2.tgz, is created in the folder silk/silk-workbench/target/universal/. The tar file 
contains the script to run the workbench. It must be copied in the docker image to be unzipped in a docker container

### Run the Silk Workbench 
In order to start the workbench with the transformation rules, run the following command 

    $ sbt -Dworkspace.provider.file.dir=somefolder\data-integration-workspace\Workspace -Dhttp.port=9005 "project workbench" run

Note: Port is specified for not having conflicts with default port 9000 which can be used for development purposes.
