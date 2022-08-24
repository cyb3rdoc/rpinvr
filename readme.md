# Simple Network Video Recorder  in Node.js & Docker
This is a simple Network Video Recorder (NVR) that is designed to run on cheap hardware, such as a Raspberry Pi with a hard drive. 24/7 video streams from network cameras are saved, and the recorded files are browsable from a basic web interface.

![Camera locations](/app/images/camera-locations.png)

The project is deliberately bare-bones, and configuration is done through `.json` files.

The camera video streams are saved in 5 minute files (to prevent long periods of video loss should a file become corrupted). At 01:00 UTC, the video files for the previous day are concatinated into a single 24 hour file, and the 5 minute video files are deleted.

`ffmpeg` is used to connect to the camera streams and save the video feeds.

## Use docker-compose.yml OR build image using Dockerfile
Clone the docker branch of the repo to build your own image.
You can also use prebuilt image hum8lefool/rpinvr with docker-compose.yml.

Mount following volumes to update camera settings and access or backup stored video files.
1. /usr/src/app/config
2. /usr/src/app/storage
