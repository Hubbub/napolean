cmd = `which mpstat`
if $? == 0
  output = `mpstat 1 1` # Get stats on a single 1 second sample.
  fields = output.split("\n")[3].split(/\s+/)

  i = 2
  %w(user nice sys iowait irq soft steal guest idle).each do |field|
    queue_gauge("system.cpu.#{field}", fields[i])
    i += 1
  end
else
  $log.warn("Skipping CPU load because mpstat is not available. Install the sysstat package.")
end
