# Based on https://github.com/dask/helm-chart/issues/129
FROM daskgateway/dask-gateway:0.9.0
COPY ./environment.yml ./environment.yml
RUN conda env update -f environment.yml
