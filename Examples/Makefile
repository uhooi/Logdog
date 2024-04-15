# Variables

# Project
product_name := Example
project_name := $(product_name).xcodeproj
scheme_name := $(product_name)

# Test
TEST_SDK := iphonesimulator
TEST_CONFIGURATION := Debug
TEST_PLATFORM := iOS Simulator
TEST_DESTINATION := 'generic/platform=$(TEST_PLATFORM)'

# Targets

.PHONY: resolve-package-dependencies
resolve-package-dependencies:
	xcodebuild \
-resolvePackageDependencies

.PHONY: build-debug
build-debug:
	xcodebuild \
-sdk $(TEST_SDK) \
-configuration $(TEST_CONFIGURATION) \
-project $(project_name) \
-scheme $(scheme_name) \
-destination $(TEST_DESTINATION) \
clean build
