variable "names" {
  type = list(string)
  default = [ "neo", "trinity", "morpheus"]
}


output "names" {
  value = [for name in var.names : "${name}-hello" ]
}

output "names-upper" {
  value = [for name in var.names: upper(name)]
}

output "extract-upper-names-when-length-less-5" {
  value = [for name in var.names: upper(name) if length(name) < 5]
  
}


variable "hero_thousand_faces" {
  type = map(string)
  default = {
    "neo" = "hero"
    "trinity" = "love interest"
    "morpheus" = "mentor"
  }
}


output "bios" {
  value = [for name, role in var.hero_thousand_faces : "${name} is the ${role}"] 
}

output "upper_roles" {
  value = {for name, role in var.hero_thousand_faces : name => upper(role) }
}


# 表示する内容は、"%{for .... } <BODY> %{endfor}" の <BODY>の部分。
output "for_directive" {
  value = "%{for name in var.names}${name}, %{endfor}"
}
# output -> "neo, trinity, morpheus, "

output "for_directive_index" {
  value = "%{for i, name in var.names}(${i}): ${name}, %{endfor}"
}

# "%{if ....} <TRUEVAL> %{endif}"  :  if ... が trueの時だけ表示する。

output "for_directive_index_if" {
  value = <<EOF
    %{for i, name in var.names}(${i}): ${name}
      %{if i < length(var.names) - 1}, %{endif}
    %{endfor}
  EOF
}

// output -> ヒアドキュメントを <<EOF EOFで使うと、内部の改行・空白などあらゆるスペースが文字列として認識されてしまう。
# <<EOT
#     (0): neo
#       , 
#     (1): trinity
#       , 
#     (2): morpheus
#      
#    
#
# EOT
//

output "for_directive_index_if_no_space" {
  value = <<EOF
  %{~ for i, name in var.names ~}(${i}):${name}
    %{~ if i < length(var.names) - 1 ~}, %{~ endif ~}
  %{~ endfor ~}
  EOF
}

// output -> チルダ「~」を文字列ディレクティブに追加することで、~の前後のスペースが削除されるらしい。(うまくいってないかも???)
# <<EOT
# (0):neo
# ,(1):trinity
# ,(2):morpheus
#
# EOT
//

output "for_directive_index_if_else_no_space" {
  value = <<EOF
  %{~ for i, name in var.names ~}(${i}):${name}
    %{~ if i < length(var.names) - 1 ~}, %{else}.%{~ endif ~}
  %{~ endfor ~}
  EOF
}

// output -> if elseを使える。
# <<EOT
# (0):neo
# , (1):trinity
# , (2):morpheus
# .
# EOT
//