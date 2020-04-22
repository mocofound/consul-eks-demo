# consul-eks-demo

A demo environment of 2 AWS regions running EKS clusters connected via consul service mesh. 


## Requirements

* terraform > 0.12
* kubectl
* k3sup
* helm > 3.0

## Create infrastructure

The terraform code creates two datacenters (us-east and us-west), as well as a consul server, mesh gateway, and EKS cluster in each.

```
cd terraform/
terraform init
terraform plan
terraform apply
cd ..

``` 

## WAN Join

After provisioning the infrastructure, you can WAN join the two datacenters using the following script. 

```
./wan_join.sh
```

# Consul k8s

To install consul in each EKS cluster, run the following command

```
./install_consul_k8s.sh
```

# OpenFAAS

To install OpenFAAS in each EKS cluster run the following command. 
```
./install_openfaas.sh
```

## Configure Consul Proxy Config for Mesh Gateways
The proxy-defaults config entry kind allows for configuring global config defaults across all services for Connect proxy configuration.
```
consul config write ./config_entries/proxy-defaults.hcl
```

## Configure Consul Service Resolver for Currency Service
The service-resolver config entry kind controls which service instances should satisfy Connect upstream discovery requests for a given service name.
```
consul config write ./config_entries/currency_failover.hcl
```

# Application Deployment

```
kubectl apply -f ./app
```


# Metrics Pipeline

```
./install_telem_stack.sh
```