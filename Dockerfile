# Based on https://github.com/dask/helm-chart/issues/129
FROM pangeo/pangeo-notebook:2020.11.18
ARG DEBIAN_FRONTEND=noninteractive

USER root
RUN echo "Installing apt-get packages..." \
    && apt-get update \
    && apt-get install -y \
        tini \
    && rm -rf /var/lib/apt/lists/*
USER ${NB_USER}

USER ${NB_USER}

# We only need to install packages not listed in this file already:
# https://github.com/pangeo-data/pangeo-docker-images/blob/master/pangeo-notebook/packages.txt
RUN echo "Installing conda packages..." \
 && mamba install -n ${CONDA_ENV} -y -c plotly \
   nibabel==2.5.1 \
   seaborn==0.9.0 \
   plotly==3.9.0 \
   statsmodels \
   xgboost \
   shap \
   && echo "Installing conda packages complete!"


# We only need to install packages not listed in this file already:
# https://github.com/pangeo-data/pangeo-docker-images/blob/master/pangeo-notebook/packages.txt
RUN echo "Installing pip packages..." \
 && HDF5_DIR=$NB_PYTHON_PREFIX \
    ${NB_PYTHON_PREFIX}/bin/pip install --no-cache-dir --no-binary=h5py \
    afqinsight \
 && echo "Installing pip packages complete!"

# Configure the entrypoint to use tini
ENTRYPOINT ["tini", "-g", "--"]
