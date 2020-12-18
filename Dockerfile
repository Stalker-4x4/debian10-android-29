from debian:10

RUN apt update && apt-get install -y \
    android-sdk git python3-pip gradle nodejs npm snap unzip  rubygems-integration ruby-dev ruby \
    wget jq curl rsync
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt update && apt-get install -y yarn

RUN pip3 install awscli
RUN npm install -g react-native-version react-native-cli bugsnag-sourcemaps expo-cli@3.21.1
RUN gem install rake bundler fastlane

RUN mkdir -p /android-sdk/cmdline-tools
WORKDIR /android-sdk/cmdline-tools

RUN wget https://dl.google.com/android/repository/commandlinetools-linux-6858069_latest.zip
RUN unzip commandlinetools-linux-6858069_latest.zip
ENV ANDROID_HOME=/android-sdk
ENV ANDROID_SDK_ROOT=/android-sdk
RUN mv cmdline-tools latest

RUN yes|/android-sdk/cmdline-tools/latest/bin/sdkmanager "platform-tools" "platforms;android-29"
RUN mkdir /src
