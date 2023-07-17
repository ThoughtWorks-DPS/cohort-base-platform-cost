# Load env vars
eval "$(op inject -i environments/prod.env)"

##Create CUR Report with Athena export
# envsubst < CUR/environments/vars.auto.tfvars.json.tpl > CUR/vars.auto.tfvars.json
# terraform -chdir=CUR init
# terraform -chdir=CUR apply

# create kubecost resources
#kubectl apply -f kubecost/manifests/namespace.yaml

#envsubst < kubecost/configMaps/productKey.json.tmpl > kubecost/configmaps/productKey.json
#kubectl create secret generic productkey \
#--save-config \
#--dry-run=client \
#--from-file=./kubecost/configMaps/productkey.json \
#-o yaml | \
#kubectl apply -n kubecost -f -

#envsubst < kubecost/configMaps/oidc-secret.json.tmpl > kubecost/configmaps/oidc-secret.json
#kubectl create secret generic kubecost-oidc-secret -n kubecost --from-file=kubecost/configMaps/oidc-secret.json

#envsubst < kubecost/vars/values-template.yaml.tmpl > kubecost/vars/values.yaml

#helm repo add kubecost https://kubecost.github.io/cost-analyzer/
#helm upgrade -i kubecost kubecost/cost-analyzer \
#    --namespace kubecost \
#    -f https://raw.githubusercontent.com/kubecost/cost-analyzer-helm-chart/master/cost-analyzer/values-eks-cost-monitoring.yaml \
#    -f kubecost/vars/values.yaml

#kubectl patch deployment -n kubecost kubecost-cost-analyzer -p '{"spec": {"template":{"metadata":{"annotations":{"traffic.sidecar.istio.io/excludeOutboundIPRanges":"10.51.0.1/32"}}}} }'
#kubectl patch deployment -n kubecost kubecost-cost-analyzer -p '{"spec": {"template":{"metadata":{"annotations":{"sidecar.istio.io/rewriteAppHTTPProbers":"true"}}}} }'
