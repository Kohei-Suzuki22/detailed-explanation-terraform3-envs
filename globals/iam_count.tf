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

// -> outputの結果は以下の感じ。resourceの配列ができる。
# user_name_count = [
#   {
#     "arn" = "arn:aws:iam::095962396456:user/neo-neo"
#     "force_destroy" = false
#     "id" = "neo-neo"
#     "name" = "neo-neo"
#     "path" = "/"
#     "permissions_boundary" = ""
#     "tags" = tomap({})
#     "tags_all" = tomap({})
#     "unique_id" = "AIDARMV6N64UGRIF3SQKM"
#   },
#   {
#     "arn" = "arn:aws:iam::095962396456:user/neo-trinity"
#     "force_destroy" = false
#     "id" = "neo-trinity"
#     "name" = "neo-trinity"
#     "path" = "/"
#     "permissions_boundary" = ""
#     "tags" = tomap({})
#     "tags_all" = tomap({})
#     "unique_id" = "AIDARMV6N64UHWQK46PDP"
#   },
#   {
#     "arn" = "arn:aws:iam::095962396456:user/neo-morpheus"
#     "force_destroy" = false
#     "id" = "neo-morpheus"
#     "name" = "neo-morpheus"
#     "path" = "/"
#     "permissions_boundary" = ""
#     "tags" = tomap({})
#     "tags_all" = tomap({})
#     "unique_id" = "AIDARMV6N64UJXK4LVH56"
#   },
# ]
//



module "users" {
  source = "git::https://github.com/Kohei-Suzuki22/detailed-explanation-terraform3-modules.git//iam?ref=v1.0.2"

  count = length(var.user_names)
  user_name = var.user_names[count.index]
  
}


# ここでは、module "users"がcount数分存在していることになるため、module.users[*]で全件数にアクセスする
output "module_user_names" {
  value = module.users[*].module_user_name
}

output "user_name_count" {
  value = aws_iam_user.example
  
}