/*
 * Native class adapter template for 'glm.Quat'.
 * WARNING: remember to copy this file to your project dir before you begin to change it.
 * Generated by the Coral Compiler v0.6.0 on Tue May 24 17:13:16 2011.
 */

#include "Quat_Adapter.h"

namespace glm {

void Quat_Adapter::getAngleAxis( glm::Quat& instance, double& degrees, glm::Vec3& axis )
{
	degrees = glm::degrees( glm::gtx::quaternion::angle( instance ) );
	axis = glm::gtx::quaternion::axis( instance );
}

double Quat_Adapter::getW( glm::Quat& instance )
{
	return instance.w;
}

void Quat_Adapter::setW( glm::Quat& instance, double w )
{
	instance.w = w;
}

double Quat_Adapter::getX( glm::Quat& instance )
{
	return instance.x;
}

void Quat_Adapter::setX( glm::Quat& instance, double x )
{
	instance.x = x;
}

double Quat_Adapter::getY( glm::Quat& instance )
{
	return instance.y;
}

void Quat_Adapter::setY( glm::Quat& instance, double y )
{
	instance.y = y;
}

double Quat_Adapter::getZ( glm::Quat& instance )
{
	return instance.z;
}

void Quat_Adapter::setZ( glm::Quat& instance, double z )
{
	instance.z = z;
}

void Quat_Adapter::conjugate( glm::Quat& instance )
{
	instance = glm::gtc::quaternion::conjugate( instance );
}

void Quat_Adapter::copy( glm::Quat& instance, const glm::Quat& q )
{
	instance = q;
}

void Quat_Adapter::cross( glm::Quat& instance, const glm::Quat& q )
{
	instance = glm::gtc::quaternion::cross( instance, q );
}

double Quat_Adapter::dot( glm::Quat& instance, const glm::Quat& q )
{
	return glm::gtc::quaternion::dot( instance, q );
}

void Quat_Adapter::fromMat4( glm::Quat& instance, const glm::Mat4& m )
{
	instance = glm::gtc::quaternion::quat_cast( m );
}

void Quat_Adapter::getXYZW( glm::Quat& instance, double& x, double& y, double& z, double& w )
{
	x = instance.x;
	y = instance.y;
	z = instance.z;
	w = instance.w;
}

void Quat_Adapter::inverse( glm::Quat& instance )
{
	instance = glm::gtc::quaternion::inverse( instance );
}

void Quat_Adapter::mix( glm::Quat& instance, const glm::Quat& q, double factor )
{
	instance = glm::gtx::quaternion::shortMix( instance, q, factor );
}

void Quat_Adapter::mul( glm::Quat& instance, const glm::Quat& q )
{
	instance = instance * q;
}
	
void Quat_Adapter::rotate( glm::Quat& instance, double degrees, const glm::Vec3& axis )
{
	instance = glm::gtc::quaternion::rotate( instance, degrees, axis );
}

void Quat_Adapter::rotationFromTo( glm::Quat& instance, const glm::Vec3& from, const glm::Vec3& to  )
{
	glm::Vec3 nFrom = glm::normalize( from );
	glm::Vec3 nTo =  glm::normalize( to );
	double angle = glm::acos( glm::dot( nFrom, nTo ) ) * 180 / 3.14159265;
	glm::Vec3 axis = glm::cross( nFrom, nTo );
	instance = glm::gtc::quaternion::rotate( glm::Quat(), angle, axis );
}

void Quat_Adapter::setXYZW( glm::Quat& instance, double x, double y, double z, double w )
{
	instance.x = x;
	instance.y = y;
	instance.z = z;
	instance.w = w;
}

} // namespace glm
