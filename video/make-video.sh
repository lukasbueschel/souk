#!/bin/sh

# encode
mencoder -nosound -ovc x264 -of avi -o "souk-60fps-720p-x264.avi" -mf fps=60 mf://*.tif

# encode with sharpening and scaling
# mencoder -nosound -ovc x264 -of avi -o "souk-60fps-720p-x264-sharpened.avi" -mf fps=60 mf://*.tif -vf scale=1280:720,unsharp=l5x5:1.5:c5x5:1.5
