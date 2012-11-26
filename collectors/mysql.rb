key_map = {
  "com_delete" => "commands.delete",
  "com_insert" => "commands.insert",
  "com_select" => "commands.select",
  "com_update" => "commands.update",
}

unless $mysql_username.nil?
  cmd = "mysql -e 'SHOW STATUS' -u#{$mysql_username}"
  cmd += " -p#{$mysql_password}" unless $mysql_password.nil?

  output = `#{cmd}`
  fields = output.split("\n").collect { |l| l.split(/\s+/).collect { |f| f.downcase.strip } }
  data = fields.inject({}) { |memo, f| memo.merge(f[0] => f[1]) }

  key_map.each do |field, key|
    queue_gauge("mysql.#{key}", data[field])
  end
else
  $log.info("Skipping MySQL status because no configuration was set")
end
