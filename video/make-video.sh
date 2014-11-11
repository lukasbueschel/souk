#!/bin/sh

# collect images
ls -1 | grep -i jpg > image.list 

# encode with sharpening
mencoder -nosound -ovc x264 -of avi -o "souk-60fps-1080p-x264-sharpened.avi" -mf type=jpeg:fps=60 mf://@image.list -vf scale=1080:675,unsharp=l5x5:1.5:c5x5:1.5

# encode
# mencoder -nosound -ovc x264 -of avi -o "souk-60fps-1080p-x264.avi" -mf type=jpeg:fps=60 mf://@image.list -vf scale=1080:675
