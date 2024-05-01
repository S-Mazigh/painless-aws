FROM satcomp-painless:common AS builder
USER root

FROM satcomp-infrastructure:worker AS mallob_liaison
WORKDIR /

COPY --from=builder /painless/painless painless

USER root

# Needed sharer libraries
RUN apt-get update && apt-get --install-recommends install -y libboost-all-dev protobuf-compiler

COPY --chown=ecs-user worker/init_solver.sh /competition/init_solver.sh
COPY --chown=ecs-user worker/worker /competition/worker
USER ecs-user
RUN chmod +x /competition/init_solver.sh
RUN chmod +x /competition/worker
