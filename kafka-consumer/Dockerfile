FROM python:3.8

RUN pip install kafka-python

WORKDIR /home/app
ENV PYTHONPATH="/home/app"
COPY main.py .

ENTRYPOINT ["python", "/home/app/main.py"]