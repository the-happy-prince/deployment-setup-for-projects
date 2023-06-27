FROM ubuntu
WORKDIR /pigeon_general_atomics
RUN apt update && apt install -y python3 python3-pip
RUN apt install gdal-bin libgdal-dev -y
COPY requirements.txt /pigeon_general_atomics
RUN pip install --upgrade pip
RUN pip3 install -r requirements.txt
RUN pip install --global-option=build_ext --global-option="-I/usr/include/gdal" GDAL==`gdal-config --version`
COPY . /pigeon_general_atomics
EXPOSE 8234
ENTRYPOINT ["bash","-c","bash /pigeon_general_atomics/entrypoint.sh"]