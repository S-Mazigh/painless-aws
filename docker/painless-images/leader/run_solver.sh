#!/bin/bash

# ==================================
#     Script from Mallob 2023
# ==================================

MAX_N_SOLVERS_PER_PROCESS=8

# export OMPI_MCA_btl_vader_single_copy_mechanism=none

# Number of threads per MPI process: Set to available hardware threads,
# but at most $MAX_N_SOLVERS_PER_PROCESS.
n_threads_per_process=$(lscpu | awk '/^Core\(s\) per socket:/ { cores_per_socket = $NF } /^Socket\(s\):/ { sockets = $NF } END { print cores_per_socket * sockets }')

if [ $n_threads_per_process -gt $MAX_N_SOLVERS_PER_PROCESS ]; then
    n_threads_per_process=$MAX_N_SOLVERS_PER_PROCESS
fi

verbosity=1

nglobalprocs=$(cat $1 | wc -l)
echo "Running Painless with $n_threads_per_process threads on $(hostname) as leader and with $nglobalprocs MPI processes in total"

#nb_solvers=$n_threads_per_process

# cloud setup
# hwthread --map-by ppr:$nglobalprocs:node:pe=$n_threads_per_process
echo "CLOUD SETUP: "
command="mpirun --mca btl_tcp_if_include eth0 --mca orte_abort_on_non_zero_status false --allow-run-as-root --hostfile $1 --bind-to none ./painless -v=$verbosity -c=$n_threads_per_process -t=1000 -sbva-timeout=120 -shr-strat=1 -shr-sleep=100000 -gshr-strat=2 -dist $2"

echo "EXECUTING: $command"
eval $command
