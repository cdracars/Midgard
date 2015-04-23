name "box1"
description "Baseline configuration for box1 system." 
run_list(
  "recipe[aegir2]"
)
 
default_attributes(
  "aegir2" => {
    "frontend" => "box1.midgard.io",
    "admin_email" => "webmaster@aegir.midgard.io"
  }
)
