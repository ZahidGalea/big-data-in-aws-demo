#
#
#resource "aws_kinesis_firehose_delivery_stream" "extended_s3_stream" {
#  name        = "tf-topic-1-stream-to-s3"
#  destination = "extended_s3"
#
#  extended_s3_configuration {
#    role_arn   = aws_iam_role.firehose_role.arn
#    bucket_arn = aws_s3_bucket.landing_bucket.arn
#
#    # Example prefix using partitionKeyFromQuery, applicable to JQ processor
#    prefix              = "data/customer_id=!{partitionKeyFromQuery:customer_id}/year=!{timestamp:yyyy}/month=!{timestamp:MM}/day=!{timestamp:dd}/hour=!{timestamp:HH}/"
#    error_output_prefix = "errors/year=!{timestamp:yyyy}/month=!{timestamp:MM}/day=!{timestamp:dd}/hour=!{timestamp:HH}/!{firehose:error-output-type}/"
#
#    # https://docs.aws.amazon.com/firehose/latest/dev/dynamic-partitioning.html
#    buffer_size = 8
#    processing_configuration {
#      enabled = "true"
#
#      # Multi-record deaggregation processor example
#      processors {
#        type = "RecordDeAggregation"
#        parameters {
#          parameter_name  = "SubRecordType"
#          parameter_value = "JSON"
#        }
#      }
#
#      # New line delimiter processor example
#      processors {
#        type = "AppendDelimiterToRecord"
#      }
#
#      # JQ processor example
#      processors {
#        type = "MetadataExtraction"
#        parameters {
#          parameter_name  = "JsonParsingEngine"
#          parameter_value = "JQ-1.6"
#        }
#        parameters {
#          parameter_name  = "MetadataExtractionQuery"
#          parameter_value = "{customer_id:.customer_id}"
#        }
#      }
#    }
#  }
#
#  tags = local.tags
#}