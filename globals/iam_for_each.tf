variable "user_names_for_each" {
  type = list(string)
  default = [ "bob", "pow" ]
}

resource "aws_iam_user" "for_each" {
  for_each = toset(var.user_names_for_each)

  name = each.value

  tags = {
    # listをsetにしたものは、each.key, each.valueどちらも同じく値(="bob", "tes", "pow")を示す。
    "each_key" = each.key
    "each_value" = each.value
  }
}

output "for_each_output" {
  value = aws_iam_user.for_each
  
}

// -> outputの結果は以下の感じ。setの値がkey,resourceがvalueのようにmapになる。
# for_each_output = {
#   "bob" = {
#     "arn" = "arn:aws:iam::095962396456:user/bob"
#     "force_destroy" = false
#     "id" = "bob"
#     "name" = "bob"
#     "path" = "/"
#     "permissions_boundary" = ""
#     "tags" = tomap({
#       "each_key" = "bob"
#       "each_value" = "bob"
#     })
#     "tags_all" = tomap({
#       "each_key" = "bob"
#       "each_value" = "bob"
#     })
#     "unique_id" = "AIDARMV6N64UECAGSXX3P"
#   }
#   "pow" = {
#     "arn" = "arn:aws:iam::095962396456:user/pow"
#     "force_destroy" = false
#     "id" = "pow"
#     "name" = "pow"
#     "path" = "/"
#     "permissions_boundary" = ""
#     "tags" = tomap({
#       "each_key" = "pow"
#       "each_value" = "pow"
#     })
#     "tags_all" = tomap({
#       "each_key" = "pow"
#       "each_value" = "pow"
#     })
#     "unique_id" = "AIDARMV6N64UGP3O6X3UH"
#   }
#   "tes" = {
#     "arn" = "arn:aws:iam::095962396456:user/tes"
#     "force_destroy" = false
#     "id" = "tes"
#     "name" = "tes"
#     "path" = "/"
#     "permissions_boundary" = ""
#     "tags" = tomap({
#       "each_key" = "tes"
#       "each_value" = "tes"
#     })
#     "tags_all" = tomap({
#       "each_key" = "tes"
#       "each_value" = "tes"
#     })
#     "unique_id" = "AIDARMV6N64UEPNTLOU6D"
#   }
# }
//


output "for_each_arn" {
  # values()関数で、{key = value}のvalueの部分をとる。
  value = values(aws_iam_user.for_each)[*].arn
}




module "module_for_each" {
  source = "git::https://github.com/Kohei-Suzuki22/detailed-explanation-terraform3-modules.git//iam?ref=v1.0.2"

  for_each = toset(var.user_names_for_each)

  user_name = "${each.value}_for_each"
}


output "module_for_each_output" {
  value = values(module.module_for_each)[*].module_user_name 
}

