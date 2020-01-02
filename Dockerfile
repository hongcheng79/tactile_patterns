FROM ubuntu:eoan

WORKDIR /usr/src/app

# setup env
RUN apt-get update && apt-get install -y locales \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8

# make sure we have python3 with pip3
RUN apt-get install -y python3-pip

# For opencv
RUN apt-get install -y libsm6 libxext6 libxrender-dev

# copy pip requirements
COPY requirements.txt .

# copy the app code
COPY webapp .

# run app specific like pip and pybabel
RUN pip3 install --no-cache-dir -r requirements.txt
RUN pybabel compile -d translations

RUN rm -rf /var/lib/apt/lists/*