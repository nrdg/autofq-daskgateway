# Based on https://github.com/dask/helm-chart/issues/129
FROM daskgateway/dask-gateway:0.9.0

ENV CONDA_VERSION=4.9.2-5
COPY ./environment.yml ./environment.yml

RUN echo "Installing Miniforge..." \
    && URL="https://github.com/conda-forge/miniforge/releases/download/${CONDA_VERSION}/Miniforge3-${CONDA_VERSION}-Linux-x86_64.sh" \
    && wget --quiet ${URL} -O miniconda.sh \
    && /bin/bash miniconda.sh -u -b -p ${CONDA_DIR} \
    && rm miniconda.sh \
    && conda install -y -c conda-forge mamba \
    && mamba clean -afy

RUN mamba env create --name base -f environment.yml \
    && mamba clean -yaf
