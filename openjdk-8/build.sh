#!/bin/bash
docker build --no-cache --build-arg NEED_OPENJFX=yes -t lucidworks/fusion-builder:openjdk-8 .
