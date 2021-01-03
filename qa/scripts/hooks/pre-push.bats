#!/usr/bin/env ../../..libs/bats/bin/bats
load '../../../lib/bats-support/load'
load '../../../lib/bats-assert/load'

SCRIPT_DIR="$BATS_TEST_DIRNAME"/../../../scripts/hooks
TEST_PREFIX="pre-push.sh -";


@test "$TEST_PREFIX should not error on branch name that matches prefix list" {
    function git() {
        echo "abc/test-name";
    }
    export -f git
    
    BATS_PREFIX_LIST="abc"
    export BATS_PREFIX_LIST

    run "$SCRIPT_DIR"/pre-commit.sh

    unset BATS_PREFIX_LIST
    assert_success
}

@test "$TEST_PREFIX should not error on patch branch" {
    function git() {
        echo "patch-1.2.3";
    }
    export -f git

    BATS_PREFIX_LIST=""
    export BATS_PREFIX_LIST

    run "$SCRIPT_DIR"/pre-commit.sh

    unset BATS_PREFIX_LIST
    assert_success
}