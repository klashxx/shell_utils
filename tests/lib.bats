#!/usr/bin/env bats

load test_helper

source $(dirname $BATS_TEST_DIRNAME)/lib.sh


@test "separator" {
  run separator
  assert_success
}

@test "supported" {
  run supported
  assert_fail
}

@test "logger" {
  run log "unit test"
  assert_success
}

@test "error" {
  run error "error test"
  assert_fail
}

@test "since" {
  run since 20120328
  assert_success
}

