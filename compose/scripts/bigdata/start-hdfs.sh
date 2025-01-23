#!/bin/bash
if [ ! -d "/data/current" ]; then
    echo "Formatting NameNode..."
    hdfs namenode -format
fi
hdfs namenode