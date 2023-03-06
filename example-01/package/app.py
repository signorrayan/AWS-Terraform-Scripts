import json
import boto3


def lambda_handler(event, context):
    s3 = boto3.resource('s3')
    # Get the first bucket in the account
    bucket_name = "YOUR-BUCKET-NAME-HERE"
    bucket = s3.Bucket(bucket_name)

    # List all objects in the bucket
    for obj in bucket.objects.all():
        print(obj.key)

    # Return a response
    return {
        'statusCode': 200,
        'body': json.dumps('File processed successfully')
    }