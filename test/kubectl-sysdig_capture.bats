#!/usr/bin/env bats

@test "it does a sysdig capture" {
  kubectl create deployment nginx --image=nginx
  POD=$(kubectl get pod | grep nginx | cut -f1 -d" ")

  run ./kubectl-sysdig_capture $POD -d 5

  kubectl delete deployment nginx

  [ "$status" -eq 0 ]
}

@test "when pod is inside a namespace it does a sysdig capture" {
  kubectl create namespace scope
  kubectl -n scope create deployment nginx --image=nginx
  POD=$(kubectl -n scope get pod | grep nginx | cut -f1 -d" ")

  run ./kubectl-sysdig_capture $POD -d 5 -n scope

  kubectl delete namespace scope

  [ "$status" -eq 0 ]
}

@test "when a pod doesn't exist it returns an error" {
  run ./kubectl-sysdig_capture nonexistentpod

  [ "$status" -eq 1 ]
}
