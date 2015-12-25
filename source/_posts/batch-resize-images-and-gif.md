---
layout: post
title: "TIL: Batch resize images and create animated gifs from command line"
date: 2015-03-03 12:31:08 +0100
comments: true
tags:
- imagemagick
- convert
- mogrify
- gif
---

Today I needed to combine some of my pictures from my mobile to an animated gif. Since using GUI tools is no option of course, here is how to do it from the command line.
First of all, make sure you have [ImageMagick](http://www.imagemagick.org/) installed on your system.

Once installed you are ready to go.
Assuming we have the following file structure and want all JPEG files to be resized.

```
.
├── 1.jpg
├── 2.jpg
├── 3.jpg
├── 4.jpg
└── output
```

To make them, let's say 25% smaller, you can run the following command:

```
mogrify -resize 25% *.jpg
```

You could also run something like:

```
mogrify -resize 1600x1200 *.jpg
```

*Note* that mogrify will replace your original files with the resized ones, so consider backing up your originals before running this.

After resizing, now create the gif using

```
convert -delay 35 -loop 0 *.jpg output/animated.gif
```

and your done, your gif will be placed in the output folder.
