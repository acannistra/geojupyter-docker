FROM ubuntu:latest
MAINTAINER Tony Cannistra <tonycan@uw.edu>

COPY geo-env-base.yml /tmp/geo-env-base.yml

RUN apt-get -qq update && apt-get -qq -y install curl bzip2 \
    && curl -sSL https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -o /tmp/miniconda.sh \
    && bash /tmp/miniconda.sh -bfp /usr/local \
    && rm -rf /tmp/miniconda.sh \
    && conda install -y python=3 \
    && conda update conda \
    && apt-get -qq -y remove curl bzip2 \
    && apt-get -qq -y autoremove \
    && apt-get autoclean \
    && rm -rf /var/lib/apt/lists/* /var/log/dpkg.log \
    && conda env create -f /tmp/geo-env-base.yml \
    && conda clean --all --yes


EXPOSE 8888

ENV PATH /opt/conda/bin:$PATH

ENTRYPOINT [ "bash", "-c" ]

CMD [ "source activate geo-env" ]
