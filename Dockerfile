FROM ubuntu:18.10
RUN apt-get update
RUN apt-get install -y xvfb
RUN apt-get install -y libglu1-mesa
RUN apt-get install -y libglib2.0-0
RUN apt-get install -y lsb-release 
RUN apt-get install -y libc6
RUN apt-get install -y libfontconfig1
RUN apt-get install -y libfreetype6
RUN apt-get install -y libgcc1
RUN apt-get install -y libstdc++6
RUN apt-get install -y libx11-6
RUN apt-get install -y libx11-xcb1
RUN apt-get install -y libxcb-shm0
RUN apt-get install -y libxcb1
RUN apt-get install -y libxrender1
RUN apt-get install -y libxt6
RUN apt-get install -y libglib2.0-0
RUN apt-get install -y libgtk-3-0
RUN Xvfb :1 -screen 0 1024x768x16 &> xvfb.log  &
RUN ps aux | grep X
RUN DISPLAY=:1.0; export DISPLAY
ENV DISPLAY=:1.0
ADD ./__run_sat.sh /tmp/
RUN chmod +x /tmp/__run_sat.sh
