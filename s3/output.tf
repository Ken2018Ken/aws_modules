
output "s3_bucket_arn" {
  value       = aws_s3_bucket.terraform_state.arn
  description = "The ARN of the s3 bucket"

}

output "dynamo_table_name" {
  value       = aws_dynamodb_table.terraform_lockss.name
  description = "This is the name of the DynamoDB table"

}


output "custom_output" {
  value       = aws_dynamodb_table.terraform_lockss.hash_key
  description = "This is the name of the DynamoDB table"

}