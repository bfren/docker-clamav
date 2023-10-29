use bf
bf env load

# Configure freshclam
def main [] {
    # get variable for easier access
    let per_day = bf env CLAMAV_FRESH_PER_DAY
    bf write $"Configuring ClamAV updater to run ($per_day) times per day."

    # freshclam flags:
    #   -d  use daemon mode
    #   -c  check n times per day
    { ^freshclam -d -c $per_day } | bf handle
}
