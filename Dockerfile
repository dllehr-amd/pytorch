FROM rocm/pytorch

COPY patches . 
COPY run.sh .
RUN ./run.sh
