#!/bin/bash
#set -e
#set -o pipefail

releases=$(wget -q -O - https://ffmpeg.org/download.html | grep -o 'href="releases/ffmpeg-[0-9.]\+tar\.bz2"' | sed -r 's_href=\"releases/ffmpeg-([0-9.]+)\.tar\.bz2\"_\1_')
list=""

mkdir -p output
cd output
for release in ${releases[@]}
do
    /bin/bash ../build-release.sh $release &
    list="$list <li><a href=\"$release/index.html\">Release version $release</a></li> "
done
wait

cd ..

read -d '' indexHTML << _EOF_
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FFmpeg Documentation</title>
</head>
<body>
    <h1>FFmpeg documentation built and hosted by <a href="https://www.nativewaves.com" target="_blank">NativeWaves</a></h1>
    <p>The source code for building the API documentation can be found in the <a href="https://github.com/nativewaves/ffmpeg-docs">GitHub repository</a></p>
    <ul>
        %s
    </ul>
</body>
</html>
_EOF_

printf "$indexHTML" "$list" > output/index.html