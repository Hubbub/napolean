uptime_in_seconds = File.read("/proc/uptime").split(" ")[0].to_f

$log.debug("Uptime in seconds: #{uptime_in_seconds}")
$log.debug("Uptime in minutes: #{uptime_in_seconds/60}")
queue_counter("system.minutes_uptime", (uptime_in_seconds/60).to_i)
