use bf
bf env load

# Download the ClamAV database
def main [] {
    # if the database already exists, don't re-download (it takes a while)
    if ($"(bf env CLAMAV_DATABASE)/main.cvd" | bf fs is_not_file) {
        bf write "Downloading ClamAV database."
        ^freshclam
    }
}
