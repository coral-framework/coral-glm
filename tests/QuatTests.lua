-----------------------------
-- Setup
-----------------------------

require "testkit.Unit"

local glm = require "glm"

-----------------------------
-- Quaternion Tests
-----------------------------

local function ASSERT_QUAT_EQ( q1, q2, errorMsg )
	local x1,y1,z1,w1 = glm.getXYZW( q1 )
	local x2,y2,z2,w2 = glm.getXYZW( q2 )
	ASSERT_DOUBLE_EQ( x1, x2, errorMsg )
	ASSERT_DOUBLE_EQ( y1, y2, errorMsg )
	ASSERT_DOUBLE_EQ( z1, z2, errorMsg )
	ASSERT_DOUBLE_EQ( w1, w2, errorMsg )
end

local q1
local q2
local q3
local q4
local m1
local v1

function getSetMatTest()
	q1 = glm.Quat()
	q2 = glm.Quat()
	glm.setXYZW( q2, 0, 1, 0, 0 )
	m1 = glm.Mat4()
	glm.rotate( m1, 180, glm.Vec3( 0, 1, 0 ), m1 )
	glm.fromMat4( m1, q1 )
	ASSERT_QUAT_EQ( q1, q2, "Error! :(" )
	
end

function dotCrossConjTest()
	q1 = glm.Quat()
	q2 = glm.Quat()
	glm.setXYZW( q1, 0, 1, 0, 0 )
	glm.setXYZW( q2, 0, -1, 0, 0 )
	glm.conjugate( q1, q1 )
	ASSERT_QUAT_EQ( q1, q2 )
	glm.setXYZW( q2, 1, -1, 0, 1 )
	glm.setXYZW( q1, 0, 1, 0, 0 )
	local result = glm.dotQuat( q1, q2 )
	q1 = glm.crossQuat( q1, q2 )
	glm.setXYZW( q2, 0, 1, -1, 1 )
	ASSERT_DOUBLE_EQ( result, -1, "Error" )
	ASSERT_QUAT_EQ( q1, q2 )
end

function invMulTest()
	q1 = glm.Quat()
	q2 = glm.Quat()
	q3 = glm.Quat()
	glm.setXYZW( q1, 1, 1, -1, 0 )
	glm.inverseQuat( q1, q2 )
	glm.mulQuat( q1, q2, q3 )
	q1 = glm.Quat()
	ASSERT_QUAT_EQ( q1, q3 )
end

function mixRotTest()
	q1 = glm.Quat()
	q2 = glm.Quat()
	glm.setXYZW( q1, 0, 1, 0, 0 )
	glm.setXYZW( q2, 1, -1, 0, 1 )
	glm.mix( q1, q2, 1/2, q1 )
	glm.setXYZW( q2, -1/2, 1, 0, -1/2 )
	ASSERT_QUAT_EQ( q1, q2 )
	glm.rotateQuat( q1, 180, glm.Vec3( 0, 1, 0 ), q1 )
	glm.setXYZW( q2, 0, -1/2, -1/2, -1 )
	ASSERT_QUAT_EQ( q1, q2 )
end

function rotationFromToTest()
	local v1 = glm.Vec3( 1, -1, 1 )
	local v2 = glm.Vec3( 10, 0.001, 0.0 )
	local q = glm.Quat()
	local qConjugate = glm.Quat()
	glm.rotationFromToQuat( v1, v2, q )
	glm.rotationFromToQuat( v2, v1, qConjugate )
	glm.normalize( q * v1, v1 )
	glm.normalize( v2, v2 )
	local x1,y1,z1 = glm.getXYZ( v1 )
	local x2,y2,z2 = glm.getXYZ( v2 )
	ASSERT_DOUBLE_EQ( x1, x2 )
	ASSERT_DOUBLE_EQ( y1, y2 )
	ASSERT_DOUBLE_EQ( z1, z2 )
	
	ASSERT_QUAT_EQ( qConjugate, glm.conjugate( q ) ) 
end

function operatorTest()
	q1 = glm.Quat()
	q2 = glm.Quat()
	q3 = glm.Quat()
	glm.setXYZW( q1, 1, 1, -1, 0 )
	glm.inverseQuat( q1, q2 )
	q3 = q1 * q2
	q1 = glm.Quat()
	ASSERT_QUAT_EQ( q1, q3 )
end
