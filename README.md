# FFmpeg API Documentation

The repository contains a few build scripts and a CircleCI configuration for building the API documentation of FFmpeg. The documentation is built using Doxygen.

The FFmpeg API documentation for all stable versions are hosted on https://ffmpeg-docs.tools.nativewaves.com/.

## How To Use

### Install Dependencies

```
sudo apt update
sudo apt install doxygen
```

### How To Build a specific version

```
# Clone this repository
git clone https://github.com/nativewaves/ffmpeg-docs

# Go into the repository
cd ffmpeg-docs

# Create a temporary directory
mkdir output

# Go into the directory
cd output

# Build the API documentation for FFmpeg 5.1
../build-release.sh 5.1
```

### How To Build all stable versions

```
# Clone this repository
git clone https://github.com/nativewaves/ffmpeg-docs

# Go into the repository
cd ffmpeg-docs

# Build the API documentation for all stable FFmpeg versions
./build-all.sh
```