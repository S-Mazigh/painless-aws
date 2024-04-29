FROM satcomp-painless:common AS builder
USER root

FROM satcomp-infrastructure:leader AS mallob_liaison

WORKDIR /

COPY --from=builder /painless/painless painless

COPY --chown=ecs-user /docker/painless-images/leader/init_solver.sh /competition/init_solver.sh
COPY --chown=ecs-user /docker/painless-images/leader/run_solver.sh /competition/run_solver.sh
COPY --chown=ecs-user /docker/painless-images/leader/solver /competition/solver
USER ecs-user
RUN chmod +x /competition/init_solver.sh
RUN chmod +x /competition/run_solver.sh
RUN chmod +x /competition/solver
