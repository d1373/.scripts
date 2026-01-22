#!/bin/sh
clip=`xclip -o | tr " " "+"`
eval "helium-browser https://search.brave.com/search?q=$clip"
