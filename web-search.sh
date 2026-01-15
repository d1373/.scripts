#!/bin/sh
clip=`xclip -o | tr " " "+"`
eval "brave https://search.brave.com/search?q=$clip"
