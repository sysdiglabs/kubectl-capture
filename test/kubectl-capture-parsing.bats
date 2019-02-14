#!/usr/bin/env bats

@test "when the command is run without specifing a pod it returns an error" {
  run ./kubectl-capture

  [ "$status" -eq 1 ]
}
