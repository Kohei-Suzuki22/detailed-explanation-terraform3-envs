# countを使ったループの例


variable "user_names" {
  type = list(string)
  default = [ "neo", "trinity", "morpheus" ]
}

# length分の要素数だけループを回す。
# count.indexは、ループしている配列数を返す。
resource "aws_iam_user" "count-example" {
  count = length(var.user_names)
  name = "neo-${var.user_names[count.index]}"
  
}

# countの0番目を取得する。
output "first_user_name" {
  value = aws_iam_user.count-example[0].name
}

# count数分の全リソースを取得する。(配列で返す。)
output "all_user_names" {
  value = aws_iam_user.count-example[*].name 
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
  value = aws_iam_user.count-example
  
}




resource "aws_iam_policy" "cloudwatch_read_only" {
  name = "cloudwatch-read-only"
  policy = data.aws_iam_policy_document.cloudwatch_read_only.json
}


data "aws_iam_policy_document" "cloudwatch_read_only" {
  statement {
    effect = "Allow"
    actions = [
      "cloudwatch:Describe",
      "cloudwatch:Get*",
      "cloudwatch:List*"
    ]
    resources = ["*"]
  }
}


resource "aws_iam_policy" "cloudwatch_full_access" {
  name = "cloudwatch_full_access"
  policy = data.aws_iam_policy_document.cloudwatch_full_access.json
}

data "aws_iam_policy_document" "cloudwatch_full_access" {
  statement {
    effect = "Allow"
    actions = ["cloudwatch:*"]
    resources = ["*"]
  }
}


variable "give_neo_cloudwatch_full_access_policy" {
  type = bool
  default = false
}


resource "aws_iam_user_policy_attachment" "give_neo_cloudwatch_read_only" {
  count = var.give_neo_cloudwatch_full_access_policy ? 0 : 1

  user = aws_iam_user.count-example[0].name
  policy_arn = aws_iam_policy.cloudwatch_read_only.arn
}


resource "aws_iam_user_policy_attachment" "give_neo_cloudwatch_full_access" {
  count = var.give_neo_cloudwatch_full_access_policy ? 1 : 0


  user = aws_iam_user.count-example[0].name
  policy_arn = aws_iam_policy.cloudwatch_full_access.arn
}

output "neo_cloudwatch_policy_arn" {
  value = one(concat(aws_iam_user_policy_attachment.give_neo_cloudwatch_full_access[*].policy_arn, aws_iam_user_policy_attachment.give_neo_cloudwatch_read_only[*].policy_arn))
  
}

moved {
  from = aws_iam_user.count
  to = aws_iam_user.count-example
}