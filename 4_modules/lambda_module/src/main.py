import boto3
import uuid
import json

from urllib.parse import unquote_plus

s3_client = boto3.client("s3")
dynamodb_client = boto3.resource("dynamodb")
table = dynamodb_client.Table("SensorLogs")


def file_to_dynamodb(path):
    with open(path, "r") as infile:
        for line in infile.readlines():
            row = json.loads(line)

            table.put_item(
                Item={
                    "SensorId": row["SensorId"],
                    "Timestamp": row["Timestamp"],
                    "Status": row["Status"]
                }
            )


def process_file(event, context):
    for record in event['Records']:
        bucket = record['s3']['bucket']['name']
        key = unquote_plus(record['s3']['object']['key'])
        tmpkey = key.replace('/', '')
        download_path = '/tmp/{}{}'.format(uuid.uuid4(), tmpkey)
        print(f"file location: {bucket}/{key}")
        s3_client.download_file(bucket, key, download_path)
        file_to_dynamodb(download_path)
