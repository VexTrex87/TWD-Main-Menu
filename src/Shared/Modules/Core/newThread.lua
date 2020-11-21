return function(func, ...)
	local thread = coroutine.create(func)
	local success, errorMsg = coroutine.resume(thread, ...)
	if not success then
		warn(errorMsg)
		error(debug.traceback(thread))
	end
end