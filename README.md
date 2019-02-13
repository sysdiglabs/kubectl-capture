# Kubectl Sysdig Capture plugin

Sysdig is a powerful open source tool for container troubleshooting, performance
tunning and security investigation.

This repository implements a `kubectl` plugin which triggers a capture in the
underlying host which is running a pod. A capture file is created for a
duration of time and is download locally in order to use it with
[Sysdig Inspect](https://sysdig.com/opensource/inspect/).

## Installing

In order to use this plugin, just copy the `kubectl-sysdig_capture` to your
PATH, and ensure it has execution permissions.

You can verify its installation using `kubectl`:

```bash
$ kubectl plugin list
The following kubectl-compatible plugins are available:

/usr/local/bin/kubectl-sysdig_capture
```

In this case is installed into /usr/local/bin, but will work with another
location listed in PATH.

## Getting started

Once you have the `kubectl` plugin installed, you can start taking captures:

```bash
$ kubectl sysdig-capture nginx-78f5d695bd-bcbd8
Sysdig is starting to capture system calls. See details below:

Node: gke-sysdig-work-default-pool-c2d817f5-ggwv
Pod: nginx-78f5d695bd-bcbd8
Duration: 120 seconds

Your capture is now available at sysdig-capture-1550080529-nginx-78f5d695bd-bcbd8.scap.gz
```

And then, you can start troubleshooting with [Sysdig Inspect](https://sysdig.com/opensource/inspect/).

### Extra initialization time

When the capture container is being spinned, it takes some time to compile the
Sysdig Kernel module and start to capture system calls. You can check the logs
of the Sysdig Capture Pod if you need to know with accuracy when Sysdig starts
to capture.

## Parameters

There are a few parameters for this plugin:

| Flag               | Description                                                   |
|--------------------|---------------------------------------------------------------|
| `-d | --duration`  | The duration in seconds that Sysdig is capturing system calls |
| `-n | --namespace` | The namespace scope of the target Pod                         |

## Cleanup

You can uninstall this plugin from `kubectl` by simply removing it from your
PATH:

```bash
$ rm /usr/local/bin/kubectl-sysdig_capture
```
