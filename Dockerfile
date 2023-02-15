FROM registry.access.redhat.com/ubi8/python-39:latest

USER root

WORKDIR /microservice/
COPY . .

RUN pip install -r /microservice/requirements.txt
#RUN /opt/app-root/bin/python3.9 -m pip install --upgrade pip
RUN pip uninstall -y setuptools urllib3
RUN pip install setuptools==67.2.0
RUN pip install urllib3==1.26.14
RUN python -m pip uninstall -y pip
RUN python get-pip.py
RUN yum -y update

CMD [ "uvicorn", "server:app", "--reload", "--host", "0.0.0.0", "--port", "1234" ]
