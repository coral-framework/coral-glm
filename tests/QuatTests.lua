-----------------------------
-- Setup
-----------------------------

local glm = require "glm"

local DOUBLE_TOLERANCE = 1e-7

-----------------------------
-- Quaternion Tests
-----------------------------

local function ASSERT_QUAT_EQ( q1, q2 )
	local x1,y1,z1,w1 = glm.getXYZW( q1 )
	local x2,y2,z2,w2 = glm.getXYZW( q2 )
	ASSERT_NEAR( x1, x2, DOUBLE_TOLERANCE )
	ASSERT_NEAR( y1, y2, DOUBLE_TOLERANCE )
	ASSERT_NEAR( z1, z2, DOUBLE_TOLERANCE )
	ASSERT_NEAR( w1, w2, DOUBLE_TOLERANCE )
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
	ASSERT_QUAT_EQ( q1, q2 )
	
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
	ASSERT_DOUBLE_EQ( result, -1 )
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
	ASSERT_NEAR( x1, x2, DOUBLE_TOLERANCE )
	ASSERT_NEAR( y1, y2, DOUBLE_TOLERANCE )
	ASSERT_NEAR( z1, z2, DOUBLE_TOLERANCE )
	
	ASSERT_QUAT_EQ( qConjugate, glm.conjugate( q ) ) 
end

function getAngleAxisTest()
	local q = glm.Quat()
	glm.setXYZW( q, 0, 1, 0, 0 )
	glm.rotateQuat( q, 180, glm.Vec3( 0, 1, 0 ) )
	
	local angle, axis = glm.getAngleAxis( q )
	ASSERT_NEAR( angle, 180 )
	ASSERT_NEAR( axis.x, 0 )
	ASSERT_NEAR( axis.y, 1 )
	ASSERT_NEAR( axis.z, 0 )
end

function getAngleAxisTest2()
	local q = glm.Quat()
	glm.setXYZW( q, 0, 1, 0, 0 )
	glm.rotateQuat( q, 180, glm.Vec3( 1, 0, 0 ) )
	
	local angle, axis = glm.getAngleAxis( q )
	ASSERT_DOUBLE_EQ( angle, 180, DOUBLE_TOLERANCE )
	ASSERT_DOUBLE_EQ( axis.x, 0, DOUBLE_TOLERANCE )
	ASSERT_DOUBLE_EQ( axis.y, 1, DOUBLE_TOLERANCE )
	ASSERT_DOUBLE_EQ( axis.z, 0, DOUBLE_TOLERANCE )
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
