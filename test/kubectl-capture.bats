#!/usr/bin/env bats

@test "it does a capture" {
  kubectl create deployment nginx --image=nginx
  POD=$(kubectl get pod | grep nginx | cut -f1 -d" ")

  run ./kubectl-capture $POD -M 5

  kubectl delete deployment nginx

  [ "$status" -eq 0 ]
  [ -f ${lines[-1]} ]
}

@test "it does a capture using ebpf" {
  kubectl create deployment nginx-ebpf --image=nginx
  POD=$(kubectl get pod | grep nginx-ebpf | cut -f1 -d" ")

  run ./kubectl-capture $POD --ebpf -M 5

  kubectl delete deployment nginx-ebpf

  [ "$status" -eq 0 ]
  [ -f ${lines[-1]} ]
}

@test "when pod is inside a namespace it does a capture" {
  kubectl create namespace scope
  kubectl -n scope create deployment nginx-namespace --image=nginx
  POD=$(kubectl -n scope get pod | grep nginx-namespace | cut -f1 -d" ")

  run ./kubectl-capture $POD -M 5 -ns scope

  kubectl delete namespace scope

  [ "$status" -eq 0 ]
}

@test "when a pod doesn't exist it returns an error" {
  run ./kubectl-capture nonexistentpod

  [ "$status" -eq 1 ]
}
