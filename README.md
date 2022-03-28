# Service Discovery

## Description
Service Discovery is a contract that is using to collect service addresses and manage and find them.

## Usage
- Find all services:<br>
`./service-discovery-ops.sh all`
- Add service:<br>
  `./service-discovery-ops.sh add '<addr>' '["tag1", "tag2", "tag3"]'`
- Remove service:<br>
  `./service-discovery-ops.sh remove '<addr>'`
- Find services:<br>
  `./service-discovery-ops.sh find '["tag1", "tag3"]'`

## Address
https://net.ton.dev
`0:9496eab9b056657cde50ea5fd2052845d439272ee67db0b1472bb7601720bfb7`