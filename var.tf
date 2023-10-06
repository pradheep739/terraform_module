variable "aws_secret_pubkey" {
    default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCrnuf6sBAdB9zLIZ4a99LuNRugWqS4GC3ZhJUYmAiPELz6SPrE8UsaVh35BXY9z7wFP9npEBvxSd9T8MdoCn82F7Mna57B76THVMeKqx5HVXgtKzCsWFoOcZbLW3L/HiQkHlCUYx3PBXlMVNBwebha6FrVyicioGXQCkJUJEHJNPHSbf93arcIUwGi0PzHHT44od3E/HPllrw3HasytSPCIs237Bp3mcH7UVXhdBo2HvL33/dG7bDmKtQ9TfVoLXWOGxWeZGaMwfDXJLb2gasA3LqYDZ4tWyHfAOr9MimagFpwiBWwM/DYkypL2/UMpNbxgtIXMaO/P8o8uBFWCppWbxCRW59yIJBEoU2T+hAEnYWCX1vCX2roT/yok7Xbuok1OtOoU7Bhza0S5jTgY9UOdcrcUOGJtm8qJeehpIhgYWJ8At5tSaQERBlPkkrQYFE0kiO+5zMgMfnJ/YjEt2sRiuCrwyebcvj7b/JCVK4pW7L8OkM2qrY9pNF1hUrOQBU="
}
variable "aws_secret_keypair" {
    default = "mykey/ec2keypair"
}
variable "ec2_key_name" {
    default = "mykey"
}
variable "region" {}