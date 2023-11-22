use bf
bf env load

# Set environment variables
def main [] {
    let etc = "/etc/clamav"
    bf env set CLAMAV_ETC $etc
    bf env set "CLAMAV_CLAMD_CONF" $"($etc)/clamd.conf"
    bf env set "CLAMAV_FRESHCLAM_CONF" $"($etc)/freshclam.conf"

    bf env set "CLAMAV_DATABASE" $"/var/lib/clamav"

    # return nothing
    return
}
