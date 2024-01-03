# countを使ったループの例


variable "user_names" {
  type = list(string)
  default = [ "neo", "trinity", "morpheus" ]
}

# length分の要素数だけループを回す。
# count.indexは、ループしている配列数を返す。
resource "aws_iam_user" "example" {
  count = length(var.user_names)
  name = "neo-${var.user_names[count.index]}"
  
}

# countの0番目を取得する。
output "first_user_name" {
  value = aws_iam_user.example[0].name
}

# count数分の全リソースを取得する。(配列で返す。)
output "all_user_names" {
  value = aws_iam_user.example[*].name
  
}