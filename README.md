# Napolean, lover of metric

This is a Ruby tool to collect metrics and submit them to Librato metrics. To make it work you'll need:

* Ruby
* A Librato Metrics account

## Installing

Napolean is a Ruby gem, so just run `gem install napolean`, you'll then need to create a config file. By
default /etc/napolean.conf will be loaded, but you can specify any other path on the command line. It should
look like this:

    $librato_username = "bob@example.org"
    $librato_key = "YOUR API KEY"

    # Provide some MySQL credentials to collect stats on command usage
    # $mysql_username = "root"
    # $mysql_password = "password"

    # The source to list metrics from. Defaults to the current machine's hostname.
    $source = `hostname --fqdn`.strip

    # Turn this on for testing so that data doesn't get submitted to Librato.
    $do_not_submit = false

## Running Napolean

It goes a little something like this: `napolean [/path/to/napolean.conf]`. If you want to use the default
config file from /etc/napolean.conf just run `napolean`. It'll log to STDOUT, if you want to send it elsewhere
pipe that to `logger`.
