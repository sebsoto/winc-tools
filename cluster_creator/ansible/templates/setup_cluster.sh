set -e
BINARY_DIR=~/.local/bin
CLUSTER_DIR=~/clusters
CLUSTER_NAME="$(whoami)-$(date +%m-%d-%y)"
PULL_SECRET=~/.pull-secret.json
mkdir -p $BINARY_DIR

# Get latest oc and openshift-install binaries
/usr/local/bin/oc adm release extract -a $PULL_SECRET --command=oc registry.svc.ci.openshift.org/ocp/release:4.4 --to $BINARY_DIR
$BINARY_DIR/oc adm release extract -a $PULL_SECRET --command=openshift-install registry.svc.ci.openshift.org/ocp/release:4.4 --to $BINARY_DIR

# Create the cluster directory
mkdir -p $CLUSTER_DIR/aws/$CLUSTER_NAME

# Create the installer configuration
PULL_SECRET_CONTENTS="$(cat ~/.pull-secret.json)"
SSH_KEY="$(cat ~/.ssh/authorized_keys)"
cat /opt/cc/aws-install-config.yaml | sed "s/pullSecret: ''/pullSecret: '$PULL_SECRET_CONTENTS'/"| sed "s/sshKey: ''/sshKey: '$SSH_KEY'/"| sed "s/name: ''/name: $CLUSTER_NAME/" > $CLUSTER_DIR/aws/$CLUSTER_NAME/install-config.yaml

# Create the cluster
$BINARY_DIR/openshift-install create cluster --dir $CLUSTER_DIR/aws/$CLUSTER_NAME --log-level info
