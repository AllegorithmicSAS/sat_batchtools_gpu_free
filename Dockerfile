FROM ubuntu:18.10
RUN apt-get update
RUN apt-get install -y xvfb libglu1-mesa libglib2.0-0 lsb-release libc6 libfontconfig1 libfreetype6 libgcc1 libstdc++6 libx11-6 libx11-xcb1 libxcb-shm0 libxcb1 libxrender1 libxt6 libglib2.0-0 libgtk-3-0 libxkbcommon-x11-dev libxkbcommon-dev
RUN Xvfb :1 -screen 0 1024x768x16 &> xvfb.log  &
RUN ps aux | grep X
RUN DISPLAY=:1.0; export DISPLAY
ENV DISPLAY=:1.0
ADD ./__run_sat.sh /tmp/
ADD ./libpng15.so.15 /usr/lib/
RUN chmod +x /tmp/__run_sat.sh
# ENV QT_DEBUG_PLUGINS=1
