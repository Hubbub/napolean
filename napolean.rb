require 'bundler/setup'
require 'librato/metrics'
require 'logger'

def queue(name, value, type = :gauge)
  $log.info("Tracking #{name} as #{value}")
  $queue.add(name => { :value => value, :source => $source, :type => type, :measure_time => $start_time.to_i })
end

def queue_counter(name, value)
  queue(name, value, :counter)
end

def queue_gauge(name, value)
  queue(name, value, :gauge)
end


$log = Logger.new(STDOUT)
$log.level = Logger::DEBUG

$log.info("Starting Napolean")

$log.info("Loading configuration from config.rb")
load("config.rb")

$log.info("Configuring Librato Metrics for #{$librato_username}")
Librato::Metrics.authenticate $librato_username, $librato_key
$queue = Librato::Metrics::Queue.new

$start_time = Time.now

Dir.glob("collectors/*.rb").each do |collector|
  name = collector.gsub(/^collectors\/(.*)\.rb$/, "\\1")

  $log.info("Collecting metric: #{name}")
  load(collector)
end

run_time = Time.now - $start_time
$log.info("Metrics gathering complete in #{run_time} seconds")
queue_gauge("system.napolean.run_time", run_time)

$log.info("Flushing queue")
unless $do_not_submit
  begin
    $queue.submit
  rescue Librato::Metrics::ClientError => e
    require 'irb'
    IRB.start
  end
end
