# hipGraph in PyTorch support for ROCm 5.2.1

Current hipGraph support for PyTorch is waiting on an upstream patch from hipamd.  This build will allow users to rebuild hipamd with the necessary graph patches, and rebuild PyTorch with hipGraph enabled.

## Build docker image
```
git clone --branch graph_build https://github.com/dllehr-amd/pytorch.git
docker build --tag rocm/pytorch:1.10_hipgraph .
```

## Build within container
```
docker run -it --device=/dev/kfd --device=/dev/dri --group-add video --cap-add=SYS_PTRACE --security-opt seccomp=unconfined --shm-size=64G rocm/pytorch:rocm5.2_ubuntu20.04_py3.7_pytorch_1.10.0 bash
git clone --branch graph_build https://github.com/dllehr-amd/pytorch.git
cd pytorch
./run.sh
```



