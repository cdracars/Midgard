name "gateway"
description "Baseline configuration for gateway system." 
run_list(
  "recipe[mgrd-sysctl]",
  "recipe[sysctl::apply]",
  "recipe[mgrd-pound]",
  "recipe[mgrd-iptables-ng]"
)
 
default_attributes(

)
