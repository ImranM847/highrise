#!/bin/sh

# Bash shell script for generating a super resolution images from stacks of lower resolution photos.
# Based on https://github.com/pixlsus/Scripts/tree/master/superres

# Align parameters
c="100" # number of control points
corr="0.5" # correlation between control points
t="3"   # error margin (in pixel) for matches

# Check whether the required packages are installed
if [ ! -x "$(command -v convert)" ] || [ ! -x "$(command -v align_image_stack)" ] || [ ! -x "$(command -v exiftool)" ]; then
    echo "Install ImageMagick, Hugin, and ExifTool."
    exit 1
fi

# Usage prompt
usage(){
cat <<EOF
$0 [OPTIONS]
$0 creates a super resolution image from a stack of lower resolution photos
Usage:
  $0 -e <extention> -d <directory>
Options:
  -e --ext       File extension (e.g., JPG or jpg)
  -d --dir       Absolute path to the directory containing source photos
EOF
  exit 1
}

# Specify options
OPTS=`getopt -o e:d: -l ext:dir: -- "$@"`
[[ $# -eq 0 ]] && usage
eval set -- "$OPTS"

# Obtain paramter values
while true; do
  case "$1" in
    -e | --ext ) ext="$2"; shift 2;;
    -d | --dir ) dir="$2"; shift 2;;
    -- ) shift; break ;;
    * ) break ;;
  esac
done

# Check whether the required paramteters are specified
if [ -z "$ext" ]; then
 echo "File extension is not specified"
exit 1
fi
if [ -z "$dir" ]; then
 echo "Source directory is not specified"
exit 1
fi

# Create scratch directory for temporary file
mkdir -p $dir/resized || exit 1
cd $dir

# Upscale images by 200% (4x more pixels) and copy them to the scratch directory
convert *.$ext -resize 200% $dir/resized/%04d.jpg
cd $dir/resized || exit 1

# Auto-align resized images and crop them to aligned area
align_image_stack --use-given-order --distortion -C -z -a aligned --corr=$corr -t $t -c $c -v *.jpg
cd $dir

# Obtain file name of the first file in the working directory
file=$(ls *.$ext | sort -n | head -1)
filename="${file%.*}"

# Calculate average at each new pixel. Save the resulting file using the obtained file name
# Copy EXIF metadata from the first file into the resulting file
convert $dir/resized/aligned* -evaluate-sequence mean $filename-mean.$ext
exiftool -overwrite_original -tagsfromfile $file "-all:all>all:all" $filename-mean.$ext

# Calculate median at each new pixel. Save the resulting file using the obtained file name
# Copy EXIF metadata from the first file into the resulting file
convert $dir/resized/aligned* -evaluate-sequence median $filename-median.$ext
exiftool -overwrite_original -tagsfromfile $file "-all:all>all:all" $filename-mean.$ext

# Remove the scratch directory
rm -rf $dir/resized

echo "All done. You'll find the resulting $filename-mean.$ext and $filename-mean.$ext files in the working directory."

exit 0
