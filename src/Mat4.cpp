#include "Mat4_Adapter.h"
#include <gtc/matrix_transform.hpp>
#include <gtc/quaternion.hpp>

namespace glm {
	
void Mat4_Adapter::add( glm::Mat4& instance, const glm::Mat4& m )
{
	instance += m;
}	

void Mat4_Adapter::copy( glm::Mat4& instance, const glm::Mat4& m )
{
	instance = glm::Mat4( m );
}

void Mat4_Adapter::fromQuat( glm::Mat4& instance, const glm::Quat& q )
{
	instance = glm::gtc::quaternion::mat4_cast( q );
}

void Mat4_Adapter::frustum( glm::Mat4& instance, double left, double right, double bottom, double up, double nearVal, double farVal )
{
	instance = gtc::matrix_transform::frustum( left, right, bottom, up, nearVal, farVal );
}

double Mat4_Adapter::getElement( glm::Mat4& instance, co::int32 i, co::int32 j )
{
	return instance[i][j];
}

void Mat4_Adapter::identity( glm::Mat4& instance )
{
	instance = glm::Mat4();
}

void Mat4_Adapter::invert( glm::Mat4& instance )
{
	instance = glm::inverse( instance );
}

void Mat4_Adapter::lookAt( glm::Mat4& instance, const glm::Vec3& eye, const glm::Vec3& center, const glm::Vec3& up )
{
	instance = gtc::matrix_transform::lookAt( eye, center, up );
}

void Mat4_Adapter::mulScalar( glm::Mat4& instance, double value )
{
	instance *= value;
}

void Mat4_Adapter::ortho( glm::Mat4& instance, double left, double right, double bottom, double up )
{
	instance = gtc::matrix_transform::ortho( left, right, bottom, up );
}

void Mat4_Adapter::perspective( glm::Mat4& instance, double fovy, double aspect, double zNear, double zFar )
{
	instance = gtc::matrix_transform::perspective( fovy, aspect, zNear, zFar );
}

void Mat4_Adapter::posMul( glm::Mat4& instance, const glm::Mat4& m )
{
	instance = m * instance;
}

void Mat4_Adapter::preMul( glm::Mat4& instance, const glm::Mat4& m )
{
	instance *= m;
}

void Mat4_Adapter::rotate( glm::Mat4& instance, double degrees, const glm::Vec3& axis )
{
	instance = gtc::matrix_transform::rotate(  instance, degrees, axis );
}

void Mat4_Adapter::scale( glm::Mat4& instance, const glm::Vec3& scale )
{
	instance = gtc::matrix_transform::scale( instance, scale );
}

void Mat4_Adapter::translate( glm::Mat4& instance, const glm::Vec3& position )
{
	instance = gtc::matrix_transform::translate( instance, position );
}

void Mat4_Adapter::transpose( glm::Mat4& instance )
{
	instance = glm::transpose( instance );
}

} // namespace glm
