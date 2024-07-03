provider "aws" {
region = ""us-east-1"
profile = "tf-user"
}
rsource "aws_iam_user" "1"{
    name = "shiv"
}
rsource "aws_iam_user" "1"{
    name = "pavan"
}
 resource "aws_iam_group" "grp" {
    name = "cloud"
 }
resource "aws_iam_group_membership" "team" {
  name = "tf-testing-group-membership"

  users = [
    aws_iam_user.1.name,
    aws_iam_user.2.name,
  ]

  group = aws_iam_group.grp.name
} 