variable "project"          { type = string }
variable "instance_type"    {
     type = string
 default = "t3.small" 
 }
variable "subnet_id"        { type = string }
variable "sg_id"            { type = string }
variable "key_name"         { type = string }
variable "root_volume_size" { 
    type = number 
    default = 20 
    }
variable "tags"             {
     type = map(string)
 default = {} 
 }
