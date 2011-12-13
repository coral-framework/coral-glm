while true do
	io.write( "> " )
	command = io.stdin:read'*l'
	print(command)
	result, err = pcall( command )
	if not result then
		print( err )
	end
end
	
	