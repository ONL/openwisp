#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "update.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM python:3.6

RUN apt-get update && apt-get install -y \
    openssl \
    sqlite3 \
    libsqlite3-dev \
    libssl-dev \
    gdal-bin \
    libproj-dev \
    libgeos-dev \
    libspatialite-dev \
    zlib1g \
    zlib1g-dev

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

ONBUILD COPY requirements.txt /usr/src/app/
ONBUILD RUN pip install --no-cache-dir -r requirements.txt

ONBUILD COPY . /usr/src/app


WORKDIR .

RUN pip3 install -U pip setuptools wheel
RUN pip3 install -U .
RUN echo "openwisp-controller installed"
WORKDIR tests/
CMD ["./docker-entrypoint.sh"]
EXPOSE 8000

VOLUME /usr/src/app/tests
ENV NAME openwisp-controller
