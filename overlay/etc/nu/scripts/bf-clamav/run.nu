use bf

# Run preflight checks before executing process
export def preflight [] {
    # load environment
    bf env load

    # manually set executing script
    bf env set X clamav/run

    # if we get here we are ready to start ClamAV
    bf write "Starting ClamAV."
}
