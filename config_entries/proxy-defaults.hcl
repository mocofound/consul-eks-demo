Kind = "proxy-defaults"
Name = "global"
config {
  envoy_dogstatsd_url = "udp://127.0.0.1:9125"
}
MeshGateway {
   Mode = "local"
}