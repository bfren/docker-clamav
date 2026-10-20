use std/assert


#======================================================================================================================
# helpers
#======================================================================================================================

# Generate a configuration file from its template in a temporary directory, and return its lines without comments
def render [name: string]: nothing -> list<string> {
    let file = $"(mktemp --directory)/($name)"
    let vars = {
        BF_CLAMAV_DATABASE: "/var/lib/clamav"
        BF_CLAMAV_CLAMD_CONF: "/etc/clamav/clamd.conf"
    }
    with-env $vars { ^esh -o $file $"/etc/bf/templates/($name).esh" }
    open --raw $file | lines | str trim | where {|x| $x != "" and not ($x starts-with "#") }
}


#======================================================================================================================
# clamd.conf
#======================================================================================================================

export def clamd__listens_on_tcp_and_socket [] {
    let conf = render clamd.conf

    assert ("TCPSocket 3310" in $conf)
    assert ("LocalSocket /run/clamav/clamd.sock" in $conf)
}

export def clamd__runs_in_foreground_using_database [] {
    let conf = render clamd.conf

    assert ("Foreground yes" in $conf) "clamd must stay in the foreground to be supervised by S6"
    assert ("DatabaseDirectory /var/lib/clamav" in $conf)
}


#======================================================================================================================
# freshclam.conf
#======================================================================================================================

export def freshclam__updates_database_and_notifies_clamd [] {
    let conf = render freshclam.conf

    assert ("DatabaseDirectory /var/lib/clamav" in $conf)
    assert ("NotifyClamd /etc/clamav/clamd.conf" in $conf) "clamd should reload the database after an update"
}
