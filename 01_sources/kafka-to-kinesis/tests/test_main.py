from kafka_to_kinesis import send_message_to_kinesis
from utils.kinesis import KinesisStream
import boto3


def test_message_to_kinesis():
    kinesis_topic_name = "tf-topic-1"
    message = '{"key": "just testing"}'
    kinesis_client = boto3.client("kinesis", region_name="us-east-1")
    kinesis_handler = KinesisStream(kinesis_client)
    kinesis_handler.name = kinesis_topic_name
    assert send_message_to_kinesis(kinesis_handler, message=message)
