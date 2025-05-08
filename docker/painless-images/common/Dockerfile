################### Build Painless
FROM satcomp-infrastructure:common
USER root
#  Install required softwares (Boost needed for Painless)

# Install required packages
RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    apt-get install -y vim cmake build-essential zlib1g-dev libopenmpi-dev wget unzip python3 gfortran curl

# g++-10 for better c++20 support
RUN apt-get --install-recommends install -y libboost-all-dev g++-10
RUN ln -sf /usr/bin/g++-10 /usr/bin/g++
#--branch satcomp-25
RUN git clone https://github.com/lip6/painless.git --branch v1.25-isc25

# Build Painless
WORKDIR /painless
RUN make -j $(nproc)