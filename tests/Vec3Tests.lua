-----------------------------
-- Setup
-----------------------------

require "testkit.Unit"

local glm = require "glm"


local function ASSERT_VEC_EQ( v1, v2, errorMsg )
	local x1,y1,z1 = glm.getXYZ( v1 )
	local x2,y2,z2 = glm.getXYZ( v2 )
	ASSERT_DOUBLE_EQ( x1, x2, errorMsg )
	ASSERT_DOUBLE_EQ( y1, y2, errorMsg )
	ASSERT_DOUBLE_EQ( z1, z2, errorMsg )
end
-----------------------------
-- vec3 Tests
-----------------------------

local v1
local v2

function basicsTest()
	v1 = glm.vec3( 1, 1, 1 )
	v2 = glm.vec3()
	v2.x = 1
	v2.y = 1
	v2.z = 1
	ASSERT_VEC_EQ( v1, v2 )
end

function crossTest()
	v1 = glm.vec3( 0, 1, 0 )
	v2 = glm.vec3( 0, 0, 1 )
	local v3 = glm.cross( v1, v2 )
	ASSERT_VEC_EQ( v3, glm.vec3( 1, 0, 0 ) )
	local v4
	glm.cross( v1, v2, v4 )
	ASSERT_VEC_EQ( v3, glm.vec3( 1, 0, 0 ) )	
end

function dotTest()
	v1 = glm.vec3( 0, 1, 0 )
	v2 = glm.vec3( 0, 0, 1 )
	local result = glm.dot( v1, v2 )
	ASSERT_DOUBLE_EQ( result, 0 )
	v1.z = 1
	result = glm.dot( v1, v2 )
	glm.cross( v1, v2, v4 )
	ASSERT_DOUBLE_EQ( result, 1 )	
end

function normLengthTest()
	v1 = glm.vec3( 0, 3, 4 )
	ASSERT_DOUBLE_EQ( glm.length( v1 ), 5 )
	glm.normalize( v1, v2 )
	ASSERT_VEC_EQ( v2, glm.vec3( 0, 3/5, 4/5 ) )
end
