local path = string.sub(..., 1, string.len(...) - string.len(".control.state"))
local context = require(path.. ".core.context")

return function (base)
	local base = base or {}
	local fakeBase = {}
	local activeContext = context.getContext()
	return setmetatable({},{
			__index = function(t, index)
				return fakeBase[index] or base[index]
			end,
			__newindex = function(t, index, val)
				if fakeBase[index] ~= val then
					fakeBase[index] = val
					activeContext:bubbleUpdate()
				end
			end
		})
end