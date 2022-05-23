local U = {}
U.prequire = function(...)
	local status, lib = pcall(require, ...)
	if status then
		return lib
	end
	return nil
end
return U
