################################################################################
# Run the test scripts with CTest
################################################################################

ADD_TEST(
	NAME tests
	COMMAND ${CORAL_LAUNCHER} --mode $<CONFIGURATION>
		lua.Launcher testkit.TestRunner ${CMAKE_SOURCE_DIR}/tests -o output/unitTests.xml
)
