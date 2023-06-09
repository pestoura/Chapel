#!/usr/bin/env bash
#
# Run performance tests on a cray-cs

CWD=$(cd $(dirname $0) ; pwd)

export CHPL_TEST_PERF_SUBDIR="cray-cs"
export CHPL_TEST_PERF_CONFIG_NAME='16-node-cs-hdr'

source $CWD/common-perf.bash

export CHPL_NIGHTLY_TEST_CONFIG_NAME="perf.cray-cs-hdr.gasnet-mpi"

source $CWD/common-cray-cs.bash y
source $CWD/common-perf-cray-cs-hdr.bash

module load openmpi/gcc

export CHPL_COMM_SUBSTRATE=mpi
export GASNET_QUIET=y
nightly_args="${nightly_args} -no-buildcheck"
perf_args="-performance-description gn-mpi -numtrials 1"

$CWD/nightly -cron ${perf_args} ${perf_cray_cs_args} ${nightly_args}
