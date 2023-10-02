#! /bin/sh

## building and running tests
colcon test --ctest-args tests [package_selection_args]

## examining test results
colcon test-result --all
colcon test-result --all --verbose

## Debugging test w/GDB

colcon build --cmake-clean-cache --mixin debug
gdb -ex run ./build/rcl/test/test_logging