use ../index/test.nu

const clamav_branches = [
    "1.2"
    "1.4"
]

# Run test suite for image
def main [
    clamav: string = "1.4"  # define which ClamAV version to use
    --all (-a)              # test all registered versions of ClamAV (overrides $clamav)
] {
    let branches = if $all { $clamav_branches } else { [$clamav] }
    test "clamav" $branches
}
