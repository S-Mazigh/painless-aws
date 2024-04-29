FROM satcomp-painless:common AS builder
USER root

FROM satcomp-infrastructure:worker AS mallob_liaison
WORKDIR /

COPY --from=builder /painless/painless painless

COPY --chown=ecs-user /docker/painless-images/worker/init_solver.sh /competition/init_solver.sh
COPY --chown=ecs-user /docker/painless-images/worker/worker /competition/worker

USER ecs-user
RUN chmod +x /competition/init_solver.sh
RUN chmod +x /competition/worker
