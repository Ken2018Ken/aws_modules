    
    variable "bucket" {
        description = "Bucket name....FIND UNIQUE BUCKET NAME"
        type = string
      
    }
  
    
    # variable "prevent_destroy" {
    #     description = "Prevent Destroy boolean"
    #     type = bool
      
    # }
    

    # variable "versioning_status_enabled" {
    #     description = "Enable or disable versioning of state"
    #     type = bool
      
    # }


    variable "sse_algorithm" {
        description = "Encryption algorithm for data at rest in the dynamo"
        type = string
      
    }

    variable "dynamodb_table_name" {
        description = "Dynamo table name"
        type = string
      
    }

    variable "billing_mode" {
        description = "AWS Billing mode on the bucket"
        type = string
      
    }
    variable "hash_key" {
        description = "HASH Key"
        type = string
      
    }
     variable "dynamodb_table_attr_name" {
        description = "Dynamo attribute name"
        type = string
      
    }

     variable "dynamodb_table_attr_type" {
        description = "Dynamo attribute type"
        type = string
      
    }


    
    




