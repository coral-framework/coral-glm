#include "Vec3_Adapter.h"

namespace glm {

double Vec3_Adapter::getX( glm::Vec3& instance  )
{
	return instance.x;
}

void Vec3_Adapter::setX( glm::Vec3& instance, double x )
{
	instance.x = x;
}

double Vec3_Adapter::getY( glm::Vec3& instance  )
{
	return instance.y;
}

void Vec3_Adapter::setY( glm::Vec3& instance, double y )
{
	instance.y = y;
}

double Vec3_Adapter::getZ( glm::Vec3& instance  )
{
	return instance.z;
}

void Vec3_Adapter::setZ( glm::Vec3& instance, double z )
{
	instance.z = z;
}

void Vec3_Adapter::getXYZ( glm::Vec3& instance, double& x, double& y, double& z  )
{
	x = instance.x;
	y = instance.y;
	z = instance.z;
}

void Vec3_Adapter::setXYZ( glm::Vec3& instance, double x, double y, double z  )
{
	instance.x = x;
	instance.y = y;
	instance.z = z;
}

void Vec3_Adapter::add( glm::Vec3& instance, const glm::Vec3& v )
{
	instance += v;
}

void Vec3_Adapter::copy( glm::Vec3& instance, const glm::Vec3& v )
{
	instance = v;
}

void Vec3_Adapter::cross( glm::Vec3& instance, const glm::Vec3& v )
{
	instance = glm::cross( instance, v );
}

double Vec3_Adapter::dot( glm::Vec3& instance, const glm::Vec3& v )
{
	return glm::dot( instance, v );
}

bool Vec3_Adapter::equals( glm::Vec3& instance, const glm::Vec3& v )
{
	return instance == v;
}

double Vec3_Adapter::length( glm::Vec3& instance )
{
	return glm::length( instance );
}

void Vec3_Adapter::mul( glm::Vec3& instance, double value )
{
	instance *= value;
}

void Vec3_Adapter::normalize( glm::Vec3& instance )
{
	instance = glm::normalize( instance );
}

void Vec3_Adapter::sub( glm::Vec3& instance, const glm::Vec3& v )
{
	instance -= v;
}

void Vec3_Adapter::transform( glm::Vec3& instance, const glm::Mat4& m )
{
	glm::precision::highp_vec4 instanceV4( instance, 1.0f );
	instanceV4 = m * instanceV4;
	instance.x = instanceV4.x;
	instance.y = instanceV4.y;
	instance.z = instanceV4.z;
}

} // namespace glm
