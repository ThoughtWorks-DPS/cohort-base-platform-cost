 #!/bin/bash
set -eo pipefail
envpath=qa

export VAULT_NAMESPACE=admin

if [[ "$envpath" =~ ^(dev|qa)$ ]]; then
  PARSED_SECRET_PATH="nonprod"
else
  PARSED_SECRET_PATH=$envpath
fi

if [[ "us-east-1" != "us-west-2" ]]; then
  PARSED_SECRET_PATH="us-east-1-$PARSED_SECRET_PATH"
fi

echo $PARSED_SECRET_PATH
