#! /bin/sh

## Source Code
#  test/tutorial_test.cpp
#include <gtest/gtest.h>

TEST(package_name, a_first_test)
{
  ASSERT_EQ(4, 2 + 2);
}

int main(int argc, char** argv)
{
  testing::InitGoogleTest(&argc, argv);
  return RUN_ALL_TESTS();
}

## adding to the package.xml

<test_depend>ament_cmake_gtest</test_depend>

## CMaleLists.txt

if(BUILD_TESTING)
  find_package(ament_cmake_gtest REQUIRED)
  ament_add_gtest(${PROJECT_NAME}_tutorial_test test/tutorial_test.cpp)
  target_include_directories(${PROJECT_NAME}_tutorial_test PUBLIC
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
    $<INSTALL_INTERFACE:include>
  )
  ament_target_dependencies(${PROJECT_NAME}_tutorial_test
    std_msgs
  )
  target_link_libraries(${PROJECT_NAME}_tutorial_test name_of_local_library)
endif()

