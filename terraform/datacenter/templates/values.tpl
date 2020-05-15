global:
  datacenter: ${datacenter_name}
  # Enterprise
  # image: "hashicorp/consul-enterprise:1.7.0-ent"
  # OSS
  image: "consul:1.7.0"
  imageK8S: "hashicorp/consul-k8s:0.12.0"
  #imageK8S: "hashicorp/consul-k8s:0.13.0"
  #imageK8S: "hashicorp/consul-k8s:0.14.0"
  # bootstrapACLs: true
  # gossipEncryption:
  #   # secretName is the name of the Kubernetes secret that holds the gossip
  #   # encryption key. The secret must be in the same namespace that Consul is installed into.
  #   secretName: "consul-gossip-encryption-key"
  #   # secretKey is the key within the Kubernetes secret that holds the gossip
  #   # encryption key.
  #   secretKey: "key"
server:
  enabled: false
client:
  enabled: true 
  grpc: true
  join: ["provider=aws tag_key=${tag} tag_value=${value}"]
ui:
  enabled: true
syncCatalog:
  enabled: true
  toConsul: true
  toK8S: true
  default: true
connectInject:
  enabled: true
  #imageEnvoy: nicholasjackson/consul-envoy:v1.7.2-v0.14.1
  imageEnvoy: nicholasjackson/consul-envoy:v1.7.0-v0.12.2
  default: true
  centralConfig:
    enabled: true
    defaultProtocol: "http"
    proxyDefaults: |
      {
      "envoy_dogstatsd_url": "udp://127.0.0.1:9125"
      }