
kind            = "service-resolver"
name            = "counting"
connect_timeout = "2s"
failover = {
  "*" = {
    service    = "counting"
    datacenters = ["west","east"]
  }
}  