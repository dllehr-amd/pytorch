FROM rocm/pytorch:rocm5.2_ubuntu20.04_py3.7_pytorch_1.10.0

# CMAKE is too old on this image.  Build 3.22.2 before compiling hip/ROCm
RUN apt update && apt install build-essential checkinstall zlib1g-dev libssl-dev -y
RUN wget https://github.com/Kitware/CMake/releases/download/v3.22.2/cmake-3.22.2.tar.gz && \
    tar -zxvf cmake-3.22.2.tar.gz && \
    cd cmake-3.22.2 && \
    ./bootstrap && \
    make && \
    make install

COPY patches ./patches 
COPY run.sh .
RUN ./run.sh
