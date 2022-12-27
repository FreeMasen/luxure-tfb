local lux = require "luxure"
local dkjson = require "dkjson"
local server = lux.Server.new()

--[[
Content-Type: application/json; charset=UTF-8
Content-Length: 28
Server: Example
Date: Wed, 17 Apr 2013 12:00:00 GMT
]]
server:get("/json", function(req, res)
  res:add_header("content-type", "application/json")
  res:add_header("server", "luxure")
  res:add_header("date", os.date("!%a, %d %b %Y %X GMT"))
  res:send(dkjson.encode({ message = "Hello, World!" }))
end)

server:get("/plaintext", function(req,res)
  res:add_header("content-type", "text/plain")
  res:add_header("server", "luxure")
  res:add_header("date", os.date("!%a, %d %b %Y %X GMT"))
  res:sent("Hello, World!")

end)


server.sock:setoption('reuseaddr', true)
server:listen(8080)
print(string.format('listening on http://%s:%s', server.sock:getsockname()))
server:run()
