bash "locale" do
  code <<-EOH
  (sudo locale-gen UTF-8)
  (sudo touch /var/lib/cloud/instance/locale-check.skip)
  EOH
  not_if { File.exists?("/var/lib/cloud/instance/locale-check.skip") }
end