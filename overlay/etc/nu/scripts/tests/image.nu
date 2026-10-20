use std/assert
use bf


#======================================================================================================================
# installation
#======================================================================================================================

export def install__clamav_matches_build [] {
    let build = with-env {BF_ETC: "/etc/bf"} { bf build | get ClamAV }
    # clamd reads its configuration file before handling --version, and the configuration is only generated on start,
    # so give it an empty one
    let conf = mktemp --tmpdir
    let installed = ^clamd $"--config-file=($conf)" --version | parse --regex 'ClamAV (?<v>\d+\.\d+\.\d+)' | get v.0
    rm --force $conf

    assert ($build | str starts-with $installed) $"ClamAV ($installed) should match the build ($build)"
}

export def install__default_configuration_is_removed [] {
    # configuration is generated from templates on start
    assert equal [] (ls /etc/clamav | get name)
}


#======================================================================================================================
# scripts
#======================================================================================================================

export def scripts__parse [] {
    let paths = [
        "/usr/bin/bf/bf-healthcheck"
        "/etc/s6-overlay/s6-rc.d/clamd/run"
        "/etc/s6-overlay/s6-rc.d/clamd/finish"
        "/etc/s6-overlay/s6-rc.d/freshclam/run"
        "/etc/s6-overlay/s6-rc.d/freshclam/finish"
        "/etc/bf/init.d/12-freshclam-download.nu"
    ]
    for path in $paths {
        let result = ^$nu.current-exe --no-config-file --commands $"nu-check ($path)" | complete
        assert equal "true" ($result.stdout | str trim) $"($path) does not parse: ($result.stderr)"
    }
}

export def services__freshclam_starts_after_database_is_downloaded [] {
    # the database is downloaded by init - if the freshclam service started first, both would update it at once
    assert ("/etc/s6-overlay/s6-rc.d/freshclam/dependencies.d/init" | path exists)
    assert ("/etc/bf/init.d/12-freshclam-download.nu" | path exists)
    assert equal 1 (ls /etc/bf/init.d | where name =~ 'freshclam' | length)
}

export def services__freshclam_and_clamd_are_enabled [] {
    for x in ["clamd" "freshclam"] {
        assert ($"/etc/s6-overlay/user-bundles.d/user/contents.d/($x)" | path exists) $"($x) should be enabled"
        assert equal "longrun" (open --raw $"/etc/s6-overlay/s6-rc.d/($x)/type" | str trim)
    }
}
