#!/usr/bin/env ../../..libs/bats/bin/bats
load '../../../lib/bats-support/load'
load '../../../lib/bats-assert/load'

SCRIPT_DIR="$BATS_TEST_DIRNAME"/../../../scripts/release

TEST_PREFIX="release-prep-upmerge.sh -";

@test "$TEST_PREFIX TODO " {
    skip
}