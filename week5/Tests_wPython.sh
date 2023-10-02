#! /bin/sh

## setting the package up
# in setup.py

tests_require=['pytest'],

## Testing Files n Folders

awesome_ros_package/
  awesome_ros_package/
      __init__.py
      fozzie.py
  package.xml
  setup.cfg
  setup.py
  tests/
      test_init.py
      test_copyright.py
      test_fozzie.py

## Test Contents

def test_math():
    assert 2 + 2 == 5   # This should fail for most mathematical systems

## Spec Commands

colcon test --packages-select <name-of-pkg> --pytest-args -k name_of_the_test_function

colcon test --event-handlers console_cohesion+
