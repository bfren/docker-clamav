use bf

# Returns true if the main ClamAV database is not in $dir - freshclam saves it as main.cvd, which becomes main.cld
# if it is later updated using differences
export def database_missing [
    dir: string # ClamAV database directory
]: nothing -> bool {
    ["main.cvd" "main.cld"] | all {|x| $"($dir)/($x)" | bf fs is_not_file }
}

# Return the arguments to run freshclam as a daemon under S6, checking for updates $per_day times a day
export def daemon_args [
    per_day: any    # Number of checks per day (1 to 50)
]: nothing -> list<string> {
    let checks = try { $per_day | into int } catch { 0 }
    if $checks < 1 or $checks > 50 {
        bf write error $"BF_CLAMAV_FRESH_PER_DAY must be a whole number from 1 to 50 \(not ($per_day)\)." freshclam/daemon_args
    }

    # flags:
    #   --foreground    don't fork into the background, so S6 can supervise it and its output reaches the container log
    #   -d              use daemon mode
    #   -c              check n times per day
    ["--foreground" "-d" "-c" ($checks | into string)]
}
