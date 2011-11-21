################################################################################
# Run the test scripts with CTest
################################################################################

CORAL_GET_PATH_STRING( coralPathStr )

ADD_TEST(
	NAME tests
	COMMAND ${CORAL_LAUNCHER} --mode $<CONFIGURATION> -p ${coralPathStr}
		lua.Launcher testkit.Run ${CMAKE_CURRENT_SOURCE_DIR} -o output/unitTests.xml
)

CORAL_TEST_ENVIRONMENT( tests )
