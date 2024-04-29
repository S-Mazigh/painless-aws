################### Build Painless
FROM satcomp-infrastructure:common
USER root
#  Install required softwares (Boost needed for GaspiKissat)

RUN DEBIAN_FRONTEND=noninteractive apt install -y vim cmake build-essential zlib1g-dev libopenmpi-dev wget unzip python3 gfortran curl libboost-all-dev

RUN git clone --branch satcomp-24 https://github.com/S-Mazigh/painless.git

RUN ls painless

# Build Painless
WORKDIR /painless
RUN make -j 64