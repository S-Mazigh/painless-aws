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
    n_ls_after_sbva=0
fi

verbosity=1

nglobalprocs=$(cat $1|wc -l)
echo "Running Painless with $n_threads_per_process threads on $(hostname) as leader and with $nglobalprocs MPI processes in total"

nb_solvers=$(($n_threads_per_process - 1))

# parallel setup
echo "PARALLEL SETUP: "
command="./painless -v=$verbosity -c=$nb_solvers -t=5000 -shr-strat=4 -shr-sleep=100000 -sbva-count=$n_sbva_per_process -ls-after-sbva=$n_ls_after_sbva -sbva-timeout=1000 $2"

echo "EXECUTING: $command"
eval $command
