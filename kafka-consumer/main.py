from kafka import KafkaConsumer
import logging
import os
import sys

logging.basicConfig(level=logging.INFO)

# Define server with port
bootstrap_servers = [os.environ["KAFKA_BOOTSTRAP_IP_PORT"]]

# Define topic name from where the message will recieve
topic_name = os.environ["TOPIC_NAME_TO_LOAD"]
print(f"Starting consuming from {topic_name}")
# Initialize consumer variable
consumer = KafkaConsumer(topic_name,
                         bootstrap_servers=bootstrap_servers,
                         auto_offset_reset='earliest',
                         enable_auto_commit=True,
                         group_id="debezium-demo"
                         )

for message in consumer:
    message = message.value
    print(message)

sys.exit(1)
