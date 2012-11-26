output = File.read("/proc/meminfo")

parts = output.split("\n").collect { |l| l.strip.split(/\s+/) }
stats = parts.inject({}) { |memo, part| memo.merge(part[0].gsub(":", "") => (part[1].to_i / 1024)) }

queue_counter("system.memory.total", stats["MemTotal"])
queue_counter("system.memory.free", stats["MemFree"])
queue_counter("system.memory.buffers", stats["Buffers"])
queue_counter("system.memory.cache", stats["Cached"])
