#!/bin/bash
docker build --build-arg NEED_OPENJFX=yes -t lucidworks/fusion-builder:openjdk-8 .
