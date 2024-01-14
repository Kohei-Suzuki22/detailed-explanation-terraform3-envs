output "primary_address" {
  description = "Connect to the database at this endpoint"
  # value = module.<module_name>.<moduleで定義したoutput名>でアクセスできる.
  # ※つまり、modulesディレクトリ内で、outputを定義する必要がある。
  value = module.primary_databases.address
}

output "primary_port" {
  description = "The port the database is listhening on"
  # value = module.<module_name>.<moduleで定義したoutput名>でアクセスできる。
  # ※つまり、modulesディレクトリ内で、outputを定義する必要がある。
  value = module.primary_databases.port
}