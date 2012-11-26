cmd = `which mpstat`
if $? == 0
  output = `iostat 1 2` # Get stats on a single 1 second sample. Run once to flush average since boot.

  lines = output.split("\n")
  lines.shift # Remove the first line.

  runs = lines.join("\n").split(/\navg-cpu.*\n/)

  data = runs.last.split("\n")
  2.times { data.shift } # CPU stats, and headings

  data.shift # Drop the headings
  data.each do |device|
    fields = device.split(/\s+/)
    device_name = fields.shift

    i = 0
    %w(iops kb_read_per_second kb_written_per_second kb_read kb_written).each do |field|
      queue_gauge("system.io.#{device_name}.#{field}", fields[i])
      i += 1
    end
  end
else
  $log.warn("Skipping IO stats because iostat is not available. Install the sysstat package.")
end
