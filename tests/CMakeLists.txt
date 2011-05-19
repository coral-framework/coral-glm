################################################################################
# Run the test scripts with CTest
################################################################################

#add coral-vl root folder in the search for tests folder
SET( CORAL_PATH ${CORAL_PATH} ${CMAKE_SOURCE_DIR} )
CORAL_GET_PATH_STRING( coralPathStr )

ADD_TEST(
	NAME tests
	COMMAND ${CORAL_LAUNCHER} --mode $<CONFIGURATION> -p ${coralPathStr}
		lua.Launcher testkit.TestRunner ${CMAKE_SOURCE_DIR}/tests -o output/unitTests.xml
)
