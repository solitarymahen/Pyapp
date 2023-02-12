FROM ubuntu
RUN apt-get update -y && \
apt-get install -y python3-pip python-dev-is-python3 && \
apt-get install -y python3-venv

COPY ./requirement.txt /app/requirement.txt

WORKDIR /app

RUN pip install -r requirement.txt

COPY . /app

ENTRYPOINT ["python3"]
CMD ["app.py"]


