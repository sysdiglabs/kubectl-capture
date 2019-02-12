#!/usr/bin/env bats

@test "it returns an error if running command without specifying a pod" {
  run ./kubectl-sysdig_capture

  [ "$status" -eq 1 ]
}

@test "it returns an error if an s3 bucket is specified without AWS credentials" {
  run ./kubectl-sysdig_capture podname --s3-bucket s3://foobar

  [ "$status" -eq 1 ]
}
