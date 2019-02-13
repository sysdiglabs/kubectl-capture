#!/usr/bin/env bats

@test "it returns an error if running command without specifying a pod" {
  run ./kubectl-sysdig_capture

  [ "$status" -eq 1 ]
}
