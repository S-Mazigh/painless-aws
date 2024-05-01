################### Build Painless
FROM satcomp-infrastructure:common
USER root
#  Install required softwares (Boost needed for GaspiKissat, Protobuf for Painless)

# Install required packages
RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    apt-get install -y vim cmake build-essential zlib1g-dev libopenmpi-dev wget unzip python3 gfortran curl 

RUN apt-get --install-recommends install -y libboost-all-dev libprotobuf-dev protobuf-compiler

RUN git clone --branch satcomp-24 https://github.com/S-Mazigh/painless.git

# Build Painless
WORKDIR /painless
RUN make -j $(nproc)