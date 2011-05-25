-----------------------------
-- Setup
-----------------------------

require "testkit.Unit"

local glm = require "glm"

-----------------------------
-- Quaternion Tests
-----------------------------

local function ASSERT_QUAT_EQ( q1, q2, errorMsg )
	local x1,y1,z1,w1 = glm.getXYZ( q1 )
	local x2,y2,z2,w2 = glm.getXYZ( q2 )
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
end

