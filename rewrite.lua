local headers = ngx.req.get_headers()
local numheaders = headers["num-headers"]
local cjson = require "cjson"

function string:split( inSplitPattern, outResults )
   if not outResults then
      outResults = {}
   end
   local theStart = 1
   local theSplitStart, theSplitEnd = string.find( self, inSplitPattern, theStart )
   while theSplitStart do
      table.insert( outResults, string.sub( self, theStart, theSplitStart-1 ) )
      theStart = theSplitEnd + 1
      theSplitStart, theSplitEnd = string.find( self, inSplitPattern, theStart )
   end
   table.insert( outResults, string.sub( self, theStart ) )
   return outResults
end

for i, v in pairs(headers) do
    ngx.req.set_header(i, nil)
end

for i=1, numheaders do
    local header = headers[i]

    local split_header = header:split(": ")
    ngx.req.set_header(split_header[1], split_header[2])
end
