#!/bin/bash

kubectl create namespace kube-tools

curl -o get_helm.sh https://raw.githubusercontent.com/kubernetes/helm/931c80edea0301a068b93a6782a8000a619dcb79/scripts/get
chmod +x get_helm.sh
./get_helm.sh

kubectl create serviceaccount --namespace kube-tools tiller
kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-tools:tiller
kubectl patch deploy --namespace kube-tools tiller-deploy -p '{"spec":{"template":{"spec":{"serviceAccount":"tiller"}}}}'      
helm init --service-account --namespace kube-tools tiller --upgrade
