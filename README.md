# hipGraph in PyTorch support for ROCm 5.2.x

Current hipGraph support for PyTorch is waiting on an upstream patch from hipamd.  This build will allow users to rebuild hipamd with the necessary graph patches, and rebuild PyTorch with hipGraph enabled.

## Build docker image
```
git clone --branch graph_build https://github.com/dllehr-amd/pytorch.git
docker build --tag rocm/pytorch:1.12_hipgraph .
```

## Build within container
```
docker run -it --device=/dev/kfd --device=/dev/dri --group-add video --cap-add=SYS_PTRACE --security-opt seccomp=unconfined --shm-size=64G rocm/pytorch bash
git clone --branch graph_build https://github.com/dllehr-amd/pytorch.git
cd pytorch
./run.sh
```



