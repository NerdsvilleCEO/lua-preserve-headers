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

function isBlank(x)
  return not not tostring(x):find("^%s*$")
end

local headers = ngx.req.raw_header(true)
local header_tbl = headers:split("\n")

num_headers = 0
for k, v in pairs (header_tbl) do
        if not isBlank(v) then
          ngx.req.set_header(k, v)
          num_headers = num_headers + 1
        end
end

ngx.req.set_header("num-headers", num_headers)
