#!/bin/bash
set -e
set -o pipefail
release=$1

echo Building documentation for FFmpeg $release

if [ -d "$release" ] && [ -n "$SKIP_BUILD" ]
then
    echo Skipping building documentation for FFmpeg $release
    exit 0
fi

# download ffmpeg
wget -q -O - "http://ffmpeg.org/releases/ffmpeg-$release.tar.bz2" | tar -jxf -
cd "ffmpeg-$release"

# upgrade Doxyfile
doxygen -u doc/Doxyfile

# add branding
sed -i 's-^PROJECT_LOGO.*-PROJECT_LOGO = ../../logo.png-g' doc/Doxyfile
sed -i 's-^HTML_HEADER.*-HTML_HEADER = ../../doxygen_header.html-g' doc/Doxyfile
sed -i 's-^HTML_FOOTER.*-HTML_FOOTER = ../../doxygen_footer.html-g' doc/Doxyfile

# build documentation
doxygen doc/Doxyfile
rm -rf ../$release
mv -f doc/doxy/html ../$release

cd ..
rm -rf "ffmpeg-$release"

echo Finished building documentation for FFmpeg $release