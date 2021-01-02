#!/usr/bin/env ../../..libs/bats/bin/bats
load '../../../lib/bats-support/load'
load '../../../lib/bats-assert/load'

SCRIPT_DIR="$BATS_TEST_DIRNAME"/../../../scripts/hooks

@test "should ignore patch branches" {
    function git() {
        echo "patch-0.0.1"
    }
    export -f git

    run "$SCRIPT_DIR"/branch-name.sh
    assert_success
}

@test "should allow default branches" {
    function git() {
        echo "fix/test-name";
    }
    export -f git

    run "$SCRIPT_DIR"/branch-name.sh

    assert_success

    function git() {
        echo "feat/test-name";
    }
    export -f git

    run "$SCRIPT_DIR"/branch-name.sh

    assert_success
}

@test "should allow branches that match output of prefix-list.sh" {
    function git() {
        echo "abc/test-name";
    }
    export -f git

    function less() {
        echo '- name: "abc"'
    }
    export -f less

    run "$SCRIPT_DIR"/branch-name.sh
    unset less

    assert_success
}

@test "should not allow branches that don't match output of prefix-list.sh" {
    function git() {
        echo "abc/test-name";
    }
    export -f git

    function less() {
        echo ''
    }
    export -f less
    
    run "$SCRIPT_DIR"/branch-name.sh
    unset less

    assert_failure
}