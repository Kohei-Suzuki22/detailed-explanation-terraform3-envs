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


# ↓　output -> "neo, trinity, morpheus, "
# 表示する内容は、"%{for .... } <BODY> %{endfor}" の <BODY>の部分。
output "for_directive" {
  value = "%{for name in var.names}${name}, %{endfor}"
}

output "for_directive_index" {
  value = "%{for i, name in var.names}(${i}): ${name}, %{endfor}"
  
}