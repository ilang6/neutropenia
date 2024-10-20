FROM python:3.12.7-slim-bullseye

USER root

WORKDIR /microservice/
COPY . .
RUN apt update -y 
RUN apt install -y \ 
                 unixodbc-dev \
                 libgomp1 \
                 curl
RUN curl https://packages.microsoft.com/keys/microsoft.asc |  tee /etc/apt/trusted.gpg.d/microsoft.asc
RUN curl https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/prod.list |  tee /etc/apt/sources.list.d/mssql-release.list
RUN apt-get update -y  
RUN ACCEPT_EULA=Y apt-get install -y msodbcsql18 
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
