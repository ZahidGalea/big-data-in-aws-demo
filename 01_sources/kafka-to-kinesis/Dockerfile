FROM python:3.8

RUN pip install kafka-python
RUN pip install pytest
RUN pip install boto3

WORKDIR /home/app
ENV PYTHONPATH="/home/app"
COPY src .

ENTRYPOINT ["python", "/home/app/kafka_to_kinesis.py"]