FROM condaforge/miniforge3:latest

ENV DEBIAN_FRONTEND=noninteractive
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Install GangSTR from Bioconda.
# Important:
#   - conda-forge must be available because Bioconda depends on it
#   - strict channel priority helps avoid mixed/incompatible dependency solves
RUN conda config --system --set channel_priority strict && \
    conda config --system --remove-key channels || true && \
    conda config --system --add channels defaults && \
    conda config --system --add channels bioconda && \
    conda config --system --add channels conda-forge && \
    conda install -y gangstr=2.5.0 && \
    conda clean -afy

# Confirm install during Docker build
RUN GangSTR --version

WORKDIR /data

ENTRYPOINT ["GangSTR"]
CMD ["--help"]
