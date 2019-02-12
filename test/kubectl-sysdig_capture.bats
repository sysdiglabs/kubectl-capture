#!/usr/bin/env bats

@test "it does a sysdig capture" {
  kubectl create deployment nginx --image=nginx
  POD=`kubectl get pod | grep nginx | cut -f1 -d" "`

  run ./kubectl-sysdig_capture $POD

  kubectl delete deployment nginx

  [ "$status" -eq 0 ]
}

@test "when a pod doesn't exist it returns an error" {
  run ./kubectl-sysdig_capture nonexistentpod

  [ "$status" -eq 1 ]
}
