#!/bin/bash
Xvfb :1 -screen 0 1024x768x16 &
echo Run command : /vlm/"$@"
/vlm/"$@"
