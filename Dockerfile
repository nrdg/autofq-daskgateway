FROM daskgateway/dask-gateway:0.9.0
COPY ./environment.yml ./environment.yml
RUN conda env update -f environment.yml
