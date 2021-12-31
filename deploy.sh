#!/bin/bash

java -Dserver.port=9090 -jar target/hello-0.0.1-SNAPSHOT.jar >/dev/null 2>&1 &
