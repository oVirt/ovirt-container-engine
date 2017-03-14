# oVirt-Containers 4.1
The repository includes CI to build images and run manifests definitions of ovirt components over openshift environment

# Details
The orchestration includes ovirt-engine deployment and kube-vdsm deamonset.
* For building images run "/bin/sh automation/build-artifacts.sh"
* To load deployment to openshift run "oc create -f os-manifests -R" (for setting openshift cluster follow [1])

[1] https://github.com/openshift/origin/blob/master/docs/cluster_up_down.md#linux
