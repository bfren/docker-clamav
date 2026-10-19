use bf
use bf-clamav
bf env load

# Download the ClamAV database - before the freshclam daemon starts, so the two don't try to update it at once
def main [] {
    # if the database already exists, don't re-download (it takes a while)
    if (bf-clamav database_missing (bf env CLAMAV_DATABASE)) {
        bf write "Downloading ClamAV database."
        { ^freshclam } | bf handle
    }
}
