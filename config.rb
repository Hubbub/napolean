$librato_username = "bob@example.org"
$librato_key = "YOUR API KEY"

$mysql_username = nil
# $mysql_username = "root" # Provide a username, and optionally a password, to track MySQL commands.
# $mysql_password = "password"

# The source to list metrics from. Defaults to the current machine's hostname.
$source = `hostname --fqdn`.strip

# Turn this on for testing so that data doesn't get submitted to Librato.
$do_not_submit = true

# Any Ruby files found in these paths will be loaded and used as collectors.
$collector_paths = [ "/usr/libexec/napolean/" ]
