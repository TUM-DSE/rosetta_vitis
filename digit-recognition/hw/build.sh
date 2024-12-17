#!/bin/bash

# Exit when any command fails
set -e
source /share/xilinx/Vitis/2023.2/settings64.sh
source /opt/xilinx/xrt/setup.sh
export PLATFORM_REPO_PATHS=/opt/xilinx/platforms/xilinx_u50_gen3x16_xdma_5_202210_1
# Make sure everything is up to date
make all

