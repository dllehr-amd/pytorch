FROM rocm/pytorch

COPY patches . 
COPY run.sh .
RUN pwd
RUN ls
RUN ./run.sh
