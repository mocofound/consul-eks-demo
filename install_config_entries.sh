#!/bin/bash
kubectl get pods
echo "Type the Consul Pod to connect to (consul-consul-sc2j4), followed by [ENTER]:"

read CONSUL_POD
nohup kubectl port-forward pod/$CONSUL_POD 8500 --pod-running-timeout=10m &


## Configure Consul Proxy Config for Mesh Gateways
sleep 5s
consul members

consul config write ./config_entries/proxy-defaults.hcl

consul config write ./config_entries/currency_failover.hcl

consul config write ./config_entries/counting_failover.hcl

consul intention create -deny web api
unset CONSUL_POD

<< COMMENT >
curl http://127.0.0.1:8500/v1/query \
    --request POST \
    --data @- << EOF 
{
  "Name": "currency",
  "Service": {
    "Service": "currency",
    "Failover": {
      "Datacenters": ["west", "east"]
    }
  }
}
EOF

curl http://127.0.0.1:8500/v1/query \
    --request POST \
    --data @- << EOF 
{
  "Name": "counting",
  "Service": {
    "Service": "counting",
    "Failover": {
      "Datacenters": ["west", "east"]
    }
  }
}
EOF

curl \
    --request DELETE \
    http://127.0.0.1:8500/v1/query/d769463b-2d9b-a4f0-8074-87dfcf968ce2

    curl \
    --request DELETE \
    http://127.0.0.1:8500/v1/query/8f246b77-f3e1-ff88-5b48-8ec93abf3e05

EOF
COMMENT