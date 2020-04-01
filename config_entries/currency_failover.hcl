kind            = "service-resolver"
name            = "currency"
connect_timeout = "7s"
failover = {
  "*" = {
    datacenters = ["west", "east"]
  }
}

