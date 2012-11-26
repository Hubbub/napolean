$librato_username = "bob@example.org"
$librato_key = "YOUR API KEY"
$mysql_username = "root"
$source = `hostname --fqdn`.strip

# Turn this on for testing so that data doesn't get submitted to Librato.
$do_not_submit = false
