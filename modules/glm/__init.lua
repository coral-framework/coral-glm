local M = {}

-------------------------------------------
--                  Types                --
-------------------------------------------
function M.vec3( x, y, z )
	out = co.new "glm.Vec3"
	if z then
		out:setXYZ( x, y, z )
	end
	return out
end

function M.matrix()
	return co.new "glm.Mat4"
end

function  M.quat()
	return 0
end

-----------------------------------------------------
--                 Functions		               --
-- All the functions mimics GLSL API. Except for   --
-- an optional "out" parameter that be used as     --
-- return value for efficiency. All functions      --
-- create and return a new type if "out" is nil    --
-----------------------------------------------------
--------------------------------------------
--           Vec3 functions               --
--------------------------------------------

-- returns the Vec3 cross product of Vec3 v1 against v2
function M.cross( v1, v2, out )
	out = out or co.new "glm.Vec3"
	
	out:copy( v1 )
	out:cross( v2 )
	return out	
end
	
-- returns the float dot product of Vec3 v1 and v2  
function M.dot( v1, v2 )
	return v1:dot( v2 )
end

-- returns the float dot product of Vec3 v1 and v2  
function M.length( v )
	return v:length()
end

-- returns the Vec3 normalized copy Vec3 v
function M.normalize( v, out )
	out = out or co.new "glm.Vec3"
	
	out:copy( v )
	out:normalize()
	return out	
end

--------- Multiple Getters/Setters ---------

-- returns the float components of Vec3 v 
function M.getXYZ( v )
	return v:getXYZ()
end

-- sets the float components x,y,z of Vec3 v  
function M.setXYZ( v, x, y, z )
	v:setXYZ( x, y, z )
end


------------- Basic Operations -----------

-- returns the Vec3 result of the Vec3s v1 + v2
function M.addVec( v1, v2, out )
	out = out or co.new "glm.Vec3"
	
	out:copy( v1 )
	out:add( v2 )
	return out	
end

-- returns the Vec3 result of v1 - v2
function M.subVec( v1, v2, out )
	out = out or co.new "glm.Vec3"
	
	out:copy( v1 )
	out:sub( v2 )
	return out	
end

-- returns the Vec3 result of Vec3 v * Scalar s
function M.mulVec( v, s, out )
	out = out or co.new "glm.Vec3"
	
	out:copy( v )
	out:mul( s )
	return out	
end

-- returns the Vec3 result of Vec3 v / Scalar s
function M.divVec( v, s, out )
	out = out or co.new "glm.Vec3"
	
	out:copy( v )
	out:mul( 1 / s )
	return out	
end

--------------------------------------------
--           Mat4 functions               --
--------------------------------------------

-- returns the Mat4 inserve of m
function M.inverse( m, out )
	out = out or co.new "glm.Mat4"
	
	out:copy( m )
	out:invert()
	return out	
end

-- returns the Mat4 inserve of m
function M.transpose( m, out )
	out = out or co.new "glm.Mat4"
	
	out:copy( m )
	out:invert()
	return out	
end


M.zeroVec = co.new "glm.Vec3"
local vecMT = getmetatable( M.zeroVec )
vecMT.__add = M.addVec
vecMT.__sub = M.subVec
vecMT.__div = M.divVec
vecMT.__mul = M.mulVec

return M