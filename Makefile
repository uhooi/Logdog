# Variables

# Project
package_name := Logdog
scheme_name := $(package_name)-Package

# Test
TEST_SDK := iphonesimulator
TEST_CONFIGURATION := Debug
TEST_PLATFORM := iOS Simulator
TEST_DESTINATION := 'generic/platform=$(TEST_PLATFORM)'

# Targets

build-debug:
	xcodebuild \
-sdk $(TEST_SDK) \
-configuration $(TEST_CONFIGURATION) \
-scheme '$(scheme_name)' \
-destination $(TEST_DESTINATION) \
clean build
