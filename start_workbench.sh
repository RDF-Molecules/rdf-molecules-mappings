#!/bin/bash
# Delete RUNNING_PID
find . -type f -name RUNNING_PID -exec rm -f {} \;

# Start Silk
./bin/silk-workbench -Dworkspace.provider.file.dir=/home/lidakra/mapping/Workspace -Dhttp.port=9005 -Dparsers.text.maxLength=1024k -Dapplication.context=/silk/ 

