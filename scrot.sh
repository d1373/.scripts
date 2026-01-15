#!/bin/bash
da=`date +%d-%m-%y-%T`
maim --select | tee /home/dhyey/Pictures/Screenshots/$da.png | xclip -selection clipboard -t image/png
