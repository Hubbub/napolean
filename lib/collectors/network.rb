run1 = File.read("/proc/net/dev")
sleep 1
run2 = File.read("/proc/net/dev")

runs = {}
[ run1, run2 ].each do |run|
  lines = run.split("\n")
  2.times { lines.shift }

  data = lines.collect { |l| l.split(/\s+/) }
  data.each do |line|
    line.shift
    ifname = line.shift.gsub(/:$/, "")

    runs[ifname] ||= []
    runs[ifname] << line
  end
end

averages = {}
runs.each do |ifname, data|
  run1, run2 = data
  last_second = []

  i = 0
  while i < 17
    last_second << (run2[i].to_i - run1[i].to_i)
    i += 1
  end

  averages[ifname] = last_second
end

{ :rx_bytes => 0, :tx_bytes => 8, :rx_errors => 2, :tx_errors => 10 }.each do |field, idx|
  averages.keys.each do |interface|
    queue_counter("system.net.#{interface}.#{field}", averages[interface][idx])
  end
end
