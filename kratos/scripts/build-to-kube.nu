#!/bin/env nu
cd $"($env.FILE_PWD)/../"
nerdctl build -t expedition-kratos:latest .
nerdctl image save expedition-kratos:latest | sudo nerdctl --address /run/k3s/containerd/containerd.sock --namespace k8s.io load 