#!/bin/bash

#cvlc --no-audio \
#    --video-filter=croppadd \
#    --croppadd-croptop=35 \
#    --croppadd-cropbottom=35 \
#    --croppadd-cropleft=100 \
#    --croppadd-cropright=100 \
#    v4l2:///dev/video0

cvlc --no-audio \
    --crop 4:3 \
    v4l2:///dev/video0
