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




#@test "invoking foo with a nonexistent file prints an error" {
#  run foo nonexistent_filename
#  echo $status
#  [ "$status" -eq 1 ]
#  [ "$output" = "foo: no such file 'nonexistent_filename'" ]
#}
#
#
#@test "ls: empty list" {
#    run nv ls
#    assert_success
#    assert_equal "Available environment(s):" "${lines[0]}"
#    assert_equal "" "${lines[1]}"
#}