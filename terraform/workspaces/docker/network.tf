resource "docker_network" "repro" {
  name     = "dev-network-repro"
  internal = true
}
