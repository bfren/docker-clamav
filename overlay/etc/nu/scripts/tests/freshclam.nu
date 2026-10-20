use std/assert
use bf-clamav


#======================================================================================================================
# database_missing
#======================================================================================================================

export def database_missing__when_directory_is_empty [] {
    assert (bf-clamav freshclam database_missing (mktemp --directory))
}

export def database_missing__is_false_with_main_cvd [] {
    let dir = mktemp --directory
    "" | save $"($dir)/main.cvd"

    assert not (bf-clamav freshclam database_missing $dir)
}

export def database_missing__is_false_with_main_cld [] {
    # main.cvd becomes main.cld when it is updated using differences
    let dir = mktemp --directory
    "" | save $"($dir)/main.cld"

    assert not (bf-clamav freshclam database_missing $dir)
}

export def database_missing__ignores_other_databases [] {
    let dir = mktemp --directory
    "" | save $"($dir)/daily.cvd"

    assert (bf-clamav freshclam database_missing $dir)
}


#======================================================================================================================
# daemon_args
#======================================================================================================================

export def daemon_args__run_as_daemon_with_checks_per_day [] {
    assert equal ["--foreground" "-d" "-c" "12"] (bf-clamav freshclam daemon_args "12")
    assert equal ["--foreground" "-d" "-c" "1"] (bf-clamav freshclam daemon_args 1)
    assert equal ["--foreground" "-d" "-c" "50"] (bf-clamav freshclam daemon_args "50")
}

export def daemon_args__fail_outside_1_to_50 [] {
    for x in ["0" "51" "-1" "lots" ""] {
        assert error { bf-clamav freshclam daemon_args $x }
    }
}
