load_avg = File.read("/proc/loadavg").split(" ")

queue_gauge("system.load_average.1", load_avg[0])
queue_gauge("system.load_average.5", load_avg[1])
queue_gauge("system.load_average.15", load_avg[2])
