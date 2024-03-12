FROM python:3.9.18-slim-bullseye

USER root

WORKDIR /microservice/
COPY . .
RUN apt update -y 
RUN apt install -y \ 
                 unixodbc-dev \
                 libgomp1   
RUN pip install -r /microservice/requirements.txt
#RUN /opt/app-root/bin/python3.9 -m pip install --upgrade pip
RUN pip uninstall -y setuptools urllib3
RUN pip install setuptools==69.1.1
RUN pip install urllib3==2.2.1
RUN python -m pip install --upgrade pip
#RUN python get-pip.py
RUN apt update -y
RUN apt upgrade -y 

CMD [ "uvicorn", "server:app", "--reload", "--host", "0.0.0.0", "--port", "1234" ]
