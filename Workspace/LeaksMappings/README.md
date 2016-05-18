# SILK data integration workspace

This project contains mapping and linking tasks executed with Silk Link Discovery Framework
General information about Silk can be found on the official [website](http://silkframework.org).

For running:
- Download SILK framework https://github.com/silk-framework/silk
- Execute the following command sbt -Dworkspace.provider.file.dir=somefolder\data-integration-workspace\Workspace -Dhttp.port=9005 "project workbench" run

Note: Port is specified for not having conflicts with default port 9000 which can be used for development purposes.
