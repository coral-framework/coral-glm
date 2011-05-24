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

function M.mat4()
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
-- create and return a new type if "out" is nil.   --
-- Do not pass the same reference to a function`s  --
-- second parameter and out. eg: 				   --	
-- local v = glm.vec3(); glm.cross( otherV, v, v ) --
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

-- returns the Vec3 result of the Vec3 v1 + Vec3 v2
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

-- returns m[i][j]
function M.getElement( m, i, j )
	return m:getElement( i, j )
end

-------- Basic Algebric operations ---------

-- returns the identity matrix
function M.identity( out ) 
	out = out or co.new "glm.Mat4"
	out:identity()
	return out
end
	
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
	out:transpose()
	return out	
end

-- rotates a copy of m of Scalar degrees around Vec3 axis and returns it
function M.rotate( m, degrees, axis, out )
	out = out or co.new "glm.Mat4"
	
	out:copy( m )
	out:rotate( degrees, axis )
	return out	
end

-- scales a copy of m by the amount on each axis of Vec3 scale and returns it
function M.scale( m, scale, out )
	out = out or co.new "glm.Mat4"
	
	out:copy( m )
	out:scale( scale )
	return out	
end

-- translates a copy of m by Vec3 position and returns it
function M.translate( m, position, out )
	out = out or co.new "glm.Mat4"
	
	out:copy( m )
	out:translate( position )
	return out	
end

-- returns the Vec3 result of ( Mat4 m * Vec3 v )
function M.transform( m, v, out )
	out = out or co.new "glm.Vec3"
	
	out:copy( v )
	out:transform( m )
	return out	 
end


-- returns the mat4 result of mat4 m1 + m2
function M.addMat( m1, m2, out )
	out = out or co.new "glm.Mat4"
	out:copy( m1 )
	out:add( m2 )
	return out
end

-- returns the mat4 result of mat4 m1 * m2
function M.mul( m1, m2, out )
	out = out or co.new "glm.Mat4"
	out:copy( m1 )
	out:preMul( m2 )
	return out
end

-- returns the mat4 result of mat4 m * double s
function M.mulScalar( m, s, out )
	out = out or co.new "glm.Mat4"
	out:copy( m )
	out:mulScalar( s )
	return out
end

------------- Camera Operations ------------

-- parameters: vec3 eye, vec3 center and vec3 up
function M.lookAt( eye, center, up, out )
	out = out or co.new "glm.Mat4"
	out:lookAt( eye, center, up )
	return out
end

-- parameters: double left, right, bottom, top
function M.ortho( left, right, bottom, top, out )
	out = out or co.new "glm.Mat4"
	out:ortho( left, right, bottom, top )
	return out
end

-- parameters: double fovy, aspect, zNear, zFar
function M.perspective( fovy, aspect, zNear, zFar, out )
	out = out or co.new "glm.Mat4"
	out:perspective( fovy, aspect, zNear, zFar )
	return out
end

-- parameters: double left, right, bottom, top, nearVal, farVal
function M.frustum( left, right, bottom, top, nearVal, farVal, out )
	out = out or co.new "glm.Mat4"
	out:frustum( left, right, bottom, top, nearVal, farVal )
	return out
end

--------------------------------------------
--          Specific operators            --
--------------------------------------------

local coTypeOf = co.typeOf

-- function for overloading the * operator for vec3 (tests which parameter is a scalar)
function M.vecMulOperator( a, b )
	if type( b ) == "number" then
		return M.mulVec( a, b )
	end
	return M.mulVec( b, a )
end

-- function for overloading the * operator for vec3 (tests which parameter is a scalar)
function M.vecDivOperator( a, b )
	if type( b ) == "number" then
		return M.divVec( a, b )
	end
	return M.divVec( b, a )
end

-- operator needs to check combinations of vec3, mat4 and scalar
function M.matMulOperator( a, b )
	typeA = coTypeOf( a )
	typeB = coTypeOf( b )
	if not typeA then
		return M.mulScalar( b, a )
	elseif typeB == "glm.Mat4" then
		return M.mul( a, b )
	elseif not typeB then
		return M.mulScalar( a, b )
	elseif typeB == "glm.Vec3" then
		return M.transform( a, b )
	else
		error( "there is no operation between a glm.mat4 and " .. typeB )
	end	
end


-- operators for mat4
M.idMat = co.new "glm.Mat4"
local matMT = getmetatable( M.idMat )
matMT.__mul = M.matMulOperator
matMT.__add = M.addMat

-- operators for vec3
M.zeroVec = co.new "glm.Vec3"
local vecMT = getmetatable( M.zeroVec )
vecMT.__add = M.addVec
vecMT.__sub = M.subVec
vecMT.__div = M.vecDivOperator
vecMT.__mul = M.vecMulOperator

return M