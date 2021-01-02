#!/usr/bin/env ../../..libs/bats/bin/bats
load '../../../lib/bats-support/load'
load '../../../lib/bats-assert/load'

SCRIPT_DIR="$BATS_TEST_DIRNAME"/../../../scripts/hooks

@test "should output default list of allowed branches" {
    function less() {
        echo ''
    }
    export -f less
    run "$SCRIPT_DIR"/prefix-list.sh
    
    unset less
    
    assert_output --partial 'feat'
    assert_output --partial 'fix'
}

@test "should include values from labels file" {
    function less() {
        echo '- name: "abc"'
    }
    export -f less

    run "$SCRIPT_DIR"/prefix-list.sh
    unset less

    assert_output --partial 'abc'
}