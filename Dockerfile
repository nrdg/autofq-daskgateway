# Based on https://github.com/dask/helm-chart/issues/129
FROM daskgateway/dask-gateway:0.9.0

ENV CONDA_VERSION=4.9.2-5
COPY ./environment.yml ./environment.yml

RUN conda install -y -c conda-forge mamba \
    && mamba clean -afy

RUN mamba env create --name base -f environment.yml \
    && mamba clean -yaf
