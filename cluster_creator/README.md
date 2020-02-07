# Cluster Creator

cd into ./tf

terraform apply

cd into ./ansible

create ansible hosts file with new VM's public IP and the "public\_key" variable set to the contents of openshift-dev.pub

create users.yaml file:

```
users:
  - name: <username>
    groups: <usergroup1>,<usergroups2>
    key: "<public ssh key for login>"
```

Run ansible playbook

Each user should log in with their ssh key and populate ~/.pull-secret.json with their full OpenShift pull secret

Every day at 3am a new cluster will be created for the user in ~/clusters/aws

## todo
* move terraform steps into ansible

* azure blocks outgoing smtp to mail providers, so sending emails isnt possible unless a mail relay is setup

* add destroying cluster job as well
