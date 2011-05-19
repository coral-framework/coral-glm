################################################################################
# Build the Module
################################################################################

CORAL_GENERATE_MODULE( _MODULE_SOURCES glm )

FILE( TO_CMAKE_PATH "$ENV{VR_SDK}" VR_SDK )
SET( GLM_INCLUDE_DIR ${VR_SDK}/glm/include )

INCLUDE_DIRECTORIES( ${CMAKE_CURRENT_SOURCE_DIR} ${CORAL_INCLUDE_DIRS} ${CMAKE_CURRENT_BINARY_DIR}/generated ${VR_SDK}/glm/include )

FILE( GLOB _SOURCE_FILES *.cpp )
FILE( GLOB _HEADER_FILES *.hpp )

ADD_LIBRARY( glm MODULE ${_HEADER_FILES} ${_SOURCE_FILES} ${_MODULE_SOURCES} )

TARGET_LINK_LIBRARIES( glm ${CORAL_LIBRARIES} )

CORAL_DEFAULT_TARGET_PROPERTIES( glm )
CORAL_MODULE_TARGET_PROPERTIES( glm )

################################################################################
# Source Groups
################################################################################

SOURCE_GROUP( "@Generated" FILES ${_MODULE_SOURCES} )
