#!/bin/bash

nohup

## Configure Consul Proxy Config for Mesh Gateways
consul config write ./config_entries/proxy-defaults.hcl

consul config write ./config_entries/currency_failover.hcl

consul config write ./config_entries/counting_failover.hcl


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