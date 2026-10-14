use bf
use bf-s6
bf env load

# Generate ClamAV configuration files
def main [] {
    bf write "Generating ClamAV configuration."
    bf-s6 esh template (bf env CLAMAV_CLAMD_CONF)
    bf-s6 esh template (bf env CLAMAV_FRESHCLAM_CONF)
}
