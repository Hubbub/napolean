output = `df -m`.split("\n")

output.shift
output.each do |line|
  fields = line.split(/\s+/)

  device = fields[0]
  mount_point = fields[5].sub(/^\/$/, "root").sub(/^\//, "").gsub(/\//, "-")

  i = 1
  %w(capacity used available percent_full).each do |field|
    queue_counter("system.disk.#{mount_point}.#{field}", fields[i].sub(/\%$/, ""))
    i += 1
  end
end
