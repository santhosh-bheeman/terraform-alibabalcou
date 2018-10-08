provider "alicloud" {
  access_key = "LTAIvSjIhJY6YXv0"
  secret_key = "yoSmtPHEjdjoIUoLs4jzM2i2GaZjMI"
  region     = "ap-south-1"
}

resource "alicloud_vpc" "vpc" {
  name       = "tf_test_alibaba"
  cidr_block = "10.0.0.0/16"
}

resource "alicloud_vswitch" "vsw" {
  name 		    = "web-subnet"
  vpc_id            = "${alicloud_vpc.vpc.id}"
  cidr_block        = "10.0.102.0/24"
  availability_zone = "ap-south-1a"
}

resource "alicloud_vswitch" "vsw1" {
  name              = "app-subnet"
  vpc_id            = "${alicloud_vpc.vpc.id}"
  cidr_block        = "10.0.103.0/24"
  availability_zone = "ap-south-1a"
}

#variable "image_name_regex" {
#  description = "The ECS image's name regex used to fetch specified image."
#  default     = "^ubuntu_16.*_64"
#}


#data "alicloud_images" "default" {
#  most_recent = true
#  owners      = "system"
#  name_regex  = "${var.image_name_regex}"
#}

#variable "image_id" {
#  description = "The image id used to launch one or more ecs instances."
#  default     = ""
#}

resource "alicloud_instance" "instance" {
  # cn-beijing
  availability_zone = "ap-south-1a"
  security_groups = ["sg-a2d12juq9hjofv1y4rjr"]

  # series III
  instance_type        = "ecs.t5-lc2m1.nano"
  system_disk_category = "cloud_efficiency"
#  image_id             = "${var.image_id == "" ? data.alicloud_images.default.images.0.id : var.image_id }"
  image_id	       = "ubuntu_16_0402_64_20G_alibase_20180409.vhd"
  instance_name        = "test_foo"
  vswitch_id = "vsw-a2dl16rn6znye7rdsoq40"
  internet_max_bandwidth_out = 10
}
