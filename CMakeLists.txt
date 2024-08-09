cmake_minimum_required(VERSION 3.10)
project(MyProject)

# Define the cache directory option
if(NOT DEFINED CacheDIR)
    set(CacheDIR "${CMAKE_SOURCE_DIR}/../cache")
endif()

# Define the output directory for binaries
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/target)

set(CMAKE_C_STANDARD 99)

# Include directories
include_directories(include unity /usr/local/include /usr/include ${CacheDIR}/microhttpd/include)

# Link directories
link_directories(/usr/local/lib /usr/lib ${CacheDIR}/microhttpd/lib)

# Source and test files
set(SRC_FILES src/main.c src/server.c)
set(TEST_FILES tests/test_main.c ${CacheDIR}/Unity/src/unity.c)

# Executable and test executable
add_executable(app ${SRC_FILES})
add_executable(test_main ${TEST_FILES} src/server.c)

# Link libraries
target_link_libraries(app microhttpd)
target_link_libraries(test_main microhttpd)

# Enable testing
enable_testing()
add_test(NAME test_main COMMAND test_main)

# Custom commands for building
add_custom_command(TARGET app
    POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E echo "Building app..."
)

add_custom_command(TARGET test_main
    POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E echo "Building test_main..."
)

# Custom target for cleaning (renamed to avoid conflict)
add_custom_target(custom_clean
    COMMAND ${CMAKE_COMMAND} -E remove_directory ${CMAKE_BINARY_DIR}
)
