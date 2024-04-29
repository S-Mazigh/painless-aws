#!/bin/bash

# ==================================
#     Script from Mallob 2023
# ==================================

MAX_N_SOLVERS_PER_PROCESS=32
MAX_N_SBVA=12
MAX_LS=2

# export OMPI_MCA_btl_vader_single_copy_mechanism=none

# Number of threads per MPI process: Set to available hardware threads,
# but at most $MAX_N_SOLVERS_PER_PROCESS.
n_threads_per_process=$(lscpu | awk '/^Core\(s\) per socket:/ { cores_per_socket = $NF } /^Socket\(s\):/ { sockets = $NF } END { print cores_per_socket * sockets }')
n_sbva_per_process=$MAX_N_SBVA
n_ls_after_sbva=$MAX_LS

if [ $n_threads_per_process -gt $MAX_N_SOLVERS_PER_PROCESS ]; then
    n_threads_per_process=$MAX_N_SOLVERS_PER_PROCESS
fi

if [ $n_threads_per_process -le $MAX_N_SBVA ]; then
    n_sbva_per_process=1
    nb_ls_after_sbva=0
fi

pwd

verbosity=0

nglobalprocs=$(cat $1|wc -l)
echo "Running Painless with $n_threads_per_process threads on $(hostname) as leader and with $nglobalprocs MPI processes in total"

nb_solvers=$(($n_threads_per_process - 1))

if [[ $nglobalprocs -gt 1 ]]; then
    # cloud setup
    # hwthread --map-by ppr:$nglobalprocs:node:pe=$n_threads_per_process
    ls painless
    echo "CLOUD SETUP: "
    command="mpirun --mca btl_tcp_if_include eth0 --allow-run-as-root --hostfile $1 --bind-to none ./painless -v=$verbosity -c=$nb_solvers -solver=k -t=1000 -shr-strat=1 -shr-sleep=100000 -dist -gshr-strat=2 -dist $2"
else
    # parallel setup
    echo "PARALLEL SETUP: "
    command="./painless -v=$verbosity -c=$nb_solvers -solver=k -t=5000 -shr-strat=4 -shr-sleep=100000 -sbva-count=$n_sbva_per_process -ls-after-sbva=$n_ls_after_sbva -sbva-timeout=1000 $2"
fi

echo "EXECUTING: $command"
eval $command
