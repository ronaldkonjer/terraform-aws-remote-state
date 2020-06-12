variable "region" {
}

variable "profile" {
}

variable "project" {
  description = "Project name"
}

variable "environment" {
  description = "Environment name"
}

variable "create_dynamodb_lock_table" {
  description = "Create a DynamoDB table for state locking. Set to false or 0 to disable. Defaults to true"
  default     = "true"
}

variable "create_s3_bucket" {
  description = "Create the S3 bucket and policy. Set to false of 0 to disable. Defaults to true"
  default     = "true"
}

variable "shared_aws_account_ids" {
  description = "A list of AWS account IDs to share the S3 bucket and DynamoDB table with."
  type        = list(string)
}

variable "namespace" {
  type        = string
  description = "Namespace (e.g. `eg` or `cp`)"
  default     = ""
}

variable "stage" {
  type        = string
  description = "Stage (e.g. `prod`, `dev`, `staging`)"
  default     = ""
}

variable "name" {
  type        = string
  description = "Name of the application"
}

variable "delimiter" {
  type        = string
  default     = "-"
  description = "Delimiter to be used between `name`, `namespace`, `stage` and `attributes`"
}

variable "enabled" {
  description = "Set to false to prevent the module from creating any resources"
  default     = "true"
}

variable "attributes" {
  type        = list(string)
  default     = []
  description = "Additional attributes (e.g. `1`)"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags (e.g. map(`BusinessUnit`,`XYZ`)"
}

variable "label_order" {
  type        = list(string)
  default     = []
  description = "The naming order of the id output and Name tag"
}

