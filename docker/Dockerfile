################### Build Painless
FROM satcomp-infrastructure
USER root

#  Install required softwares (Boost needed for Painless)

# Install required packages
RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    apt-get install -y vim cmake build-essential zlib1g-dev wget unzip python3 gfortran curl

# g++-10 for better c++20 support
RUN apt-get --install-recommends install -y libboost-all-dev g++
# RUN ln -sf /usr/bin/g++-10 /usr/bin/g++
#--tag satcomp-26
RUN git clone https://github.com/s-mazigh/painless.git

# Build Painless
WORKDIR /painless
RUN git checkout v1.27.0-isc26
RUN make USE_DIST=0 -j $(nproc)
#####

WORKDIR /

# COPY --chown=ecs-user run_solver.sh /
# RUN chmod +x /run_solver.sh
COPY --chown=ecs-user topology-isc26.json /

COPY solver_cmd.py /opt/amazon/scripting/harness/entrypoints/


