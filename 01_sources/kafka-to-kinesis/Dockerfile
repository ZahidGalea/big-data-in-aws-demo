FROM python:3.8

RUN pip install kafka-python
RUN pip install pytest

WORKDIR /home/app
ENV PYTHONPATH="/home/app"
COPY src/kafka_to_kinesis.py .

ENTRYPOINT ["python", "/home/app/main.py"]