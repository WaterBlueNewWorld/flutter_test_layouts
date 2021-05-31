FROM gitpod/workspace-full:latest

LABEL maintainer="alejandroj@tuta.io"

USER root

RUN apt-get update -y
RUN apt-get install -y gcc make build-essential wget curl unzip apt-utils xz-utils libkrb5-dev gradle libpulse0 android-tools-adb android-tools-fastboot
RUN apt remove --purge openjdk-*-jdk
RUN apt-get install -y openjdk-8-jdk

USER gitpod

# Android
ENV JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64
ENV ANDROID_HOME="/home/gitpod/.android"
ENV ANDROID_SDK_URL="https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip"
ENV ANDROID_SDK_ARCHIVE="${ANDROID_HOME}/archive"
ENV ANDROID_STUDIO_PATH="/home/gitpod/"

RUN cd "${ANDROID_STUDIO_PATH}"
RUN wget -qO android_studio.tar.gz https://redirector.gvt1.com/edgedl/android/studio/ide-zips/4.2.0.24/android-studio-ide-202.7322048-linux.tar.gz
RUN tar -xf android_studio.tar.gz
RUN rm -f android_studio.tar.gz

RUN mkdir -p "${ANDROID_HOME}"
RUN touch $ANDROID_HOME/repositories.cfg
RUN wget -q "${ANDROID_SDK_URL}" -O "${ANDROID_SDK_ARCHIVE}"
RUN unzip -q -d "${ANDROID_HOME}" "${ANDROID_SDK_ARCHIVE}"
RUN echo y | "${ANDROID_HOME}/tools/bin/sdkmanager" "platform-tools" "platforms;android-28" "build-tools;28.0.3"
RUN rm "${ANDROID_SDK_ARCHIVE}"

# Flutter
ENV FLUTTER_HOME="/home/gitpod/flutter"
RUN git clone https://github.com/flutter/flutter.git -b stable $FLUTTER_HOME
RUN $FLUTTER_HOME/bin/flutter channel master
RUN $FLUTTER_HOME/bin/flutter upgrade
RUN $FLUTTER_HOME/bin/flutter precache
RUN $FLUTTER_HOME/bin/flutter config --enable-web --no-analytics
RUN echo y | $FLUTTER_HOME/bin/flutter doctor --android-licenses -v
ENV PUB_CACHE=/workspace/.pub_cache

# Env
RUN echo 'export PATH=${ANDROID_HOME}/tools:${ANDROID_HOME}/tools/bin:${FLUTTER_HOME}/bin:${FLUTTER_HOME}/bin/cache/dart-sdk/bin:${PUB_CACHE}/bin:${FLUTTER_HOME}/.pub-cache/bin:$PATH' >>~/.bashrc
