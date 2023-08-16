local cb_factory = require "circuitbreaker"

local config = ngx.shared.waf_config

config:set("redis-host", "redis")
config:set("redis-port", 6379)
config:set("redis-password", "Admin123?")
