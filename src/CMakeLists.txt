################################################################################
# Build the Module
################################################################################

CORAL_GENERATE_MODULE( _MODULE_SOURCES glm )

INCLUDE_DIRECTORIES(
	${CORAL_INCLUDE_DIRS}
	${CMAKE_SOURCE_DIR}/include
	${CMAKE_CURRENT_BINARY_DIR}/generated
)

FILE( GLOB _SOURCE_FILES *.cpp )
FILE( GLOB _HEADER_FILES *.hpp )

ADD_LIBRARY( glm MODULE ${_HEADER_FILES} ${_SOURCE_FILES} ${_MODULE_SOURCES} )

TARGET_LINK_LIBRARIES( glm ${CORAL_LIBRARIES} )

CORAL_MODULE_TARGET( "glm" glm )

################################################################################
# Source Groups
################################################################################

SOURCE_GROUP( "@Generated" FILES ${_MODULE_SOURCES} )
