use bf
bf env load

# Generate ClamAV configuration files
def main [] {
    bf write "Generating ClamAV configuration."
    bf esh template (bf env CLAMAV_CLAMD_CONF | path basename) (bf env CLAMAV_ETC)
    bf esh template (bf env CLAMAV_FRESHCLAM_CONF | path basename) (bf env CLAMAV_ETC)
}
