#!/bin/bash
sbt -Dworkspace.provider.file.dir=/home/lidakra/mapping/Workspace -Dhttp.port=9005 "project workbench" run
