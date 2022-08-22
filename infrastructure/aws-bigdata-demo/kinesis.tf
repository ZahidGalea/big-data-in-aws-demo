# Kinesis Topic

resource "aws_kinesis_stream" "TPC1" {
  name             = "tf-topic-1"
  retention_period = 24

  shard_level_metrics = [
    "IncomingBytes",
    "OutgoingBytes",
  ]

  stream_mode_details {
    stream_mode = "ON_DEMAND"
  }

  tags = local.tags
}

# Kinesis Firehorse to S3

resource "aws_iam_role" "firehose_role" {
  name               = "firehose_test_role"
  tags               = local.tags
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "firehose.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}
