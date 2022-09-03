from kafka import KafkaConsumer
import logging
import os
import sys
from utils.kinesis import KinesisStream
import boto3

logging.basicConfig(level=logging.INFO)


class KafkaReader:
    def __init__(self, bootstrap_servers, topic_name):
        self.bootstrap_servers = bootstrap_servers
        self.topic_name = topic_name
        self.consumer = None

    def init_consumer(self):
        self.consumer = KafkaConsumer(self.topic_name,
                                      bootstrap_servers=self.bootstrap_servers,
                                      auto_offset_reset='earliest',
                                      enable_auto_commit=True,
                                      group_id="debezium-demo"
                                      )


def get_kafka_messages(bootstrap_servers: list, topic_name: str):
    kafka_reader = KafkaReader(bootstrap_servers=bootstrap_servers,
                               topic_name=topic_name)
    kafka_reader.init_consumer()
    for message in kafka_reader.consumer:
        yield message.value


def send_message_to_kinesis(kinesis_handler, message: str):
    response = kinesis_handler.put_record(message, partition_key="key")
    if response["ResponseMetadata"]["HTTPStatusCode"] == 200:
        return True
    else:
        raise f"Error in {response}"


def main(kinesis_topic_name: str, bootstrap_servers: list, topic_name: str):
    kinesis_client = boto3.client("kinesis", region_name="us-east-1")
    kinesis_handler = KinesisStream(kinesis_client)
    kinesis_handler.name = kinesis_topic_name
    for message in get_kafka_messages(bootstrap_servers=bootstrap_servers,
                                      topic_name=topic_name):
        print(message)
        send_message_to_kinesis(kinesis_handler=kinesis_handler, message=message)

    sys.exit(1)


if __name__ == '__main__':
    main("tf-topic-1",
         bootstrap_servers=[os.environ["KAFKA_BOOTSTRAP_IP_PORT"]],
         topic_name=os.environ["TOPIC_NAME_TO_LOAD"])
