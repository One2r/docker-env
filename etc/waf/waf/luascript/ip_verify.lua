local redis = require "resty.redis"
local config = ngx.shared.config

local red = redis:new()

redis.register_module_prefix("cf")

red:set_timeouts(1000, 1000, 1000) -- 1 sec

local ok, err = red:connect(config:get("redis-host"), config:get("redis-port"))
if not ok then
    ngx.log(ngx.ERR, "Failed to connect redis: ",err)
    ngx.exec("@proxy-by-waf");
end

local ok, err = red:auth(config:get("redis-password"))
if not ok then
    ngx.log(ngx.ERR, "Failed to authenticate redis: ",err)
    ngx.exec("@proxy-by-waf");
end

local ip = ngx.var.remote_addr

-- blacklist
local res, err = red:cf():exists("waf:ip:blacklist",ip)
if not res then
    ngx.log(ngx.ERR, "Failed to execute cf.exists for blacklist: ",err)
    ngx.exec("@proxy-by-waf");
end

if res == 1 then
    ngx.log(ngx.ERR, "Access denied with code 403. Matched remote_addr in blacklist")
    ngx.exit(ngx.HTTP_FORBIDDEN)
end

-- whitelist
local res, err = red:cf():exists("waf:ip:whitelist",ip)
if not res then
    ngx.log(ngx.ERR, "Failed to execute cf.exists for whitelist: ",err)
    ngx.exec("@proxy-by-waf");
end

if res == 0 then
    ngx.exec("@proxy-by-waf");
else
    ngx.exec("@proxy");
end

local ok, err = red:set_keepalive(10000, 512)
