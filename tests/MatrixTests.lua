-----------------------------
-- Setup
-----------------------------

require "testkit.Unit"

local glm = require "glm"

-----------------------------
-- Matrix Tests
-----------------------------

local m1
local m2
local m3
local m4

function elementIdRST()
	m1 = glm.Mat4()
	m2 = glm.Mat4()
	ASSERT_DOUBLE_EQ( glm.getElement( m1, 0, 0 ), 1 )
	ASSERT_DOUBLE_EQ( glm.getElement( m1, 1, 1 ), 1 )
	ASSERT_DOUBLE_EQ( glm.getElement( m1, 2, 0 ), 0 )
	
	glm.rotate( m1, 90, glm.Vec3( 0, 1, 0 ),  m1 )
	ASSERT_DOUBLE_EQ( glm.getElement( m1, 0, 0 ), 0 )
	ASSERT_DOUBLE_EQ( glm.getElement( m1, 0, 2 ), -1 )
	ASSERT_DOUBLE_EQ( glm.getElement( m1, 2, 0 ), 1 )
	
	glm.scale( m2, glm.Vec3( 2, 2, 2 ), m2 )
	ASSERT_DOUBLE_EQ( glm.getElement( m2, 0, 0 ), 2 )
	ASSERT_DOUBLE_EQ( glm.getElement( m2, 1, 1 ), 2 )
	ASSERT_DOUBLE_EQ( glm.getElement( m2, 2, 2 ), 2 )
	
	glm.identity( m1 )
	glm.translate( m1, glm.Vec3( 2, 2, 2 ), m1 )
	ASSERT_DOUBLE_EQ( glm.getElement( m1, 3, 0 ), 2 )
	ASSERT_DOUBLE_EQ( glm.getElement( m1, 3, 1 ), 2	)
	ASSERT_DOUBLE_EQ( glm.getElement( m1, 3, 2 ), 2 )
end

function invTranpTest()
	m1 = glm.Mat4()
	
	glm.translate( m1, glm.Vec3( 2, 2, 2 ), m1 )
	ASSERT_DOUBLE_EQ( glm.getElement( m1, 3, 0 ), 2 )
	ASSERT_DOUBLE_EQ( glm.getElement( m1, 3, 1 ), 2	)
	ASSERT_DOUBLE_EQ( glm.getElement( m1, 3, 2 ), 2 )
	
	glm.inverseMat( m1, m1 )
	ASSERT_DOUBLE_EQ( glm.getElement( m1, 3, 0 ), -2 )
	ASSERT_DOUBLE_EQ( glm.getElement( m1, 3, 1 ), -2 )
	ASSERT_DOUBLE_EQ( glm.getElement( m1, 3, 2 ), -2 )
	
	glm.transpose( m1, m1 )
	ASSERT_DOUBLE_EQ( glm.getElement( m1, 0, 3 ), -2 )
	ASSERT_DOUBLE_EQ( glm.getElement( m1, 1, 3 ), -2 )
	ASSERT_DOUBLE_EQ( glm.getElement( m1, 2, 3 ), -2 )
end

function cameraTest()
	m1 = glm.lookAt( glm.Vec3( 0, 0, -1 ), glm.Vec3( 0, 0, 1 ), glm.Vec3( 0, 1, 0 ) )
	ASSERT_DOUBLE_EQ( glm.getElement( m1, 0, 0 ), -1 )
	ASSERT_DOUBLE_EQ( glm.getElement( m1, 2, 2 ), -1 )
	ASSERT_DOUBLE_EQ( glm.getElement( m1, 3, 2 ), -1 )
	
	m2 = glm.frustum( -1, 1, -1, 1, 2, 4 )
	ASSERT_DOUBLE_EQ( glm.getElement( m2, 0, 0 ), 2 )
	ASSERT_DOUBLE_EQ( glm.getElement( m2, 2, 2 ), -3 )
	ASSERT_DOUBLE_EQ( glm.getElement( m2, 3, 2 ), -8 )
	
	m3 = glm.ortho( -1, 1, -1, 1 )
	ASSERT_DOUBLE_EQ( glm.getElement( m3, 0, 0 ), 1 )
	ASSERT_DOUBLE_EQ( glm.getElement( m3, 2, 2 ), -1 )
	ASSERT_DOUBLE_EQ( glm.getElement( m3, 3, 2 ), 0 )
	
	m4 = glm.perspective( 3.1415 / 2, 1.0, 1.0, 10.0 )
	ASSERT_DOUBLE_EQ( glm.getElement( m4, 0, 0 ), 72.948834620885 )
	ASSERT_DOUBLE_EQ( glm.getElement( m4, 2, 2 ), -11/9 )
	ASSERT_DOUBLE_EQ( glm.getElement( m4, 2, 3 ), -1 )
	
	m1 = m3 * m1
	ASSERT_DOUBLE_EQ( glm.getElement( m1, 0, 0 ), -1 )
	ASSERT_DOUBLE_EQ( glm.getElement( m1, 2, 2 ), 1 )
	ASSERT_DOUBLE_EQ( glm.getElement( m1, 3, 2 ), 1 )
end

function operatorsTest()
	local v1 = glm.Vec3( 0, 0, 0 )
	m1 = glm.Mat4()
	
	v1 = m1 * v1
	ASSERT_DOUBLE_EQ( v1.x, 0 )
	ASSERT_DOUBLE_EQ( v1.y, 0 )
	ASSERT_DOUBLE_EQ( v1.z, 0 )
	
	m1 = glm.translate( m1, glm.Vec3( 2, 2, 2 ) )
	v1 = m1 * v1
	ASSERT_DOUBLE_EQ( v1.x, 2 )
	ASSERT_DOUBLE_EQ( v1.y, 2 )
	ASSERT_DOUBLE_EQ( v1.z, 2 )
	
	m2 = glm.inverseMat( m1 )
	m3 = m1 * m2
	local i
	local j
	for i = 0,3 do
		for j = 0,3 do
			ASSERT_DOUBLE_EQ( glm.getElement( m3, i, j ), i == j and 1 or 0, "aaaa" )
		end
	end
	
	m3 = m3 + m3 
	for i = 0,3 do
		for j = 0,3 do
			ASSERT_DOUBLE_EQ( glm.getElement( m3, i, j ), i == j and 2 or 0, "bbbb" )
		end
	end
	
	m3 = m3 * 2
	for i = 0,3 do
		for j = 0,3 do
			ASSERT_DOUBLE_EQ( glm.getElement( m3, i, j ), i == j and 4 or 0 )
		end
	end
end

function fromQuatTest()
	local q = glm.Quat()
	glm.setXYZW( q, 0, 1, 0, 0 )
	m1 = glm.Mat4()
	glm.rotate( m1, 180, glm.Vec3( 0, 1, 0 ), m1 )
	m2 = glm.fromQuat( q )
	for i = 0,3 do
		for j = 0,3 do
			ASSERT_DOUBLE_EQ( glm.getElement( m1, i, j ), glm.getElement( m2, i, j ) )
		end
	end
end

function rotationFromToTest()
	local v1 = glm.Vec3( 1, 1, 1 )
	local v2 = glm.Vec3( 0, 10, 23 )
	local m = glm.Mat4()
	glm.rotationFromToMat4( v1, v2, m )
	glm.normalize( m * v1, v1 )
	glm.normalize( v2, v2 )
	local x1,y1,z1 = glm.getXYZ( v1 )
	local x2,y2,z2 = glm.getXYZ( v2 )
	ASSERT_DOUBLE_EQ( x1, x2 )
	ASSERT_DOUBLE_EQ( y1, y2 )
	ASSERT_DOUBLE_EQ( z1, z2 )
end
