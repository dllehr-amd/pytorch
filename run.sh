#!/bin/bash
export HIP_BRANCH=rocm-5.2.x
CWD=$PWD
rm -rf hipamd hip ROCclr ROCm-OpenCL-Runtime
git clone -b $HIP_BRANCH https://github.com/ROCm-Developer-Tools/hipamd.git
git clone -b $HIP_BRANCH https://github.com/ROCm-Developer-Tools/hip.git
git clone -b $HIP_BRANCH https://github.com/ROCm-Developer-Tools/ROCclr.git
git clone -b $HIP_BRANCH https://github.com/RadeonOpenCompute/ROCm-OpenCL-Runtime.git
export HIPAMD_DIR="$(readlink -f hipamd)"
export HIP_DIR="$(readlink -f hip)"
export ROCclr_DIR="$(readlink -f ROCclr)"
export OPENCL_DIR="$(readlink -f ROCm-OpenCL-Runtime)"


#Patch in hipGraph changes to hipamd
cd "$HIPAMD_DIR"
git apply $CWD/graph.patch

mkdir -p build; cd build
cmake  -DCMAKE_BUILD_TYPE=RelWithDebInfo -DHIP_COMMON_DIR=$HIP_DIR -DAMD_OPENCL_PATH=$OPENCL_DIR -DROCCLR_PATH=$ROCCLR_DIR -DCMAKE_PREFIX_PATH="<ROCM_PATH>/" ..
make -j$(nproc)
sudo make install


#remove existing pytorch
pip uninstall -y torch

#build Pytorch
cd /var/lib/jenkins/pytorch

#Make sure tag didn't slide on us
git checkout 2a932ebcaf9dcc02375d40d8f5c741426b634332

#Apply hipGraph Pytorch support
git apply $CWD/0001-hipGraph-support-in-PyTorch.patch

#Clean, hipify, build
python setup.py clean
tools/amd_build/build_amd.py
python setup.py develop
