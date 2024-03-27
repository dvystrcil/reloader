#!/bin/bash

# if you did not pass in version then fail
if [ "${1}" == "" ];
then
    echo "You need to provide a version of reload, with a 'v'"
    echo "example:"
    echo "   v0.13.10"
    exit 1
fi

version="${1}"
folder="kustomize/base/release/${version}"

if [ ! -d ${folder} ];
then    
    mkdir -p "${folder}"
    cd "${folder}"
    curl -s -O "https://raw.githubusercontent.com/stakater/Reloader/${version}/deployments/kubernetes/reloader.yaml"
    cp ../../../../templates/base-release-template.yaml kustomization.yaml
    cd ../../../../
    sed -i -r '/release\/v/s/v.*\.([^.]*)$/'${version}'/g' kustomize/overlays/proxmox/kustomization.yaml
fi
