# Set compiler flags.
set(CMAKE_CXX_FLAGS_DEBUG "-Wall -Wextra -ggdb -O0 -std=c++20")

# Export compile commands (for LSP use).
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
# Copy compile commands to root directory.
#
# Reference: https://stackoverflow.com/a/60910583
add_custom_target(
    do_always ALL
    ${CMAKE_COMMAND} -E copy_if_different
    ${CMAKE_BINARY_DIR}/compile_commands.json
    ${CMAKE_SOURCE_DIR}
)

# MLIR is copied to the build directory (so that LSP servers can find the
# source libraries in the development Docker container).
# TOY_MLIR_EXTERNAL_PATH denotes the location of the MLIR libraries to be
# copied.
set(TOY_BUILD_DIR "${CMAKE_SOURCE_DIR}/build")
get_filename_component(TMP_MLIR_EXTERNAL_DIRNAME ${TOY_MLIR_EXTERNAL_PATH} NAME)
set(TOY_MLIR_INSTALL_PATH "${TOY_BUILD_DIR}/${TMP_MLIR_EXTERNAL_DIRNAME}")
if(NOT EXISTS ${TOY_MLIR_INSTALL_PATH})
    message("Copying directory ${TOY_MLIR_EXTERNAL_PATH} to ${TOY_BUILD_DIR}")
    file(COPY ${TOY_MLIR_EXTERNAL_PATH} DESTINATION ${TOY_BUILD_DIR})
endif()

# Find MLIR and LLVM
find_package(LLVM REQUIRED CONFIG PATHS ${TOY_MLIR_INSTALL_PATH})
find_package(MLIR REQUIRED CONFIG PATHS ${TOY_MLIR_INSTALL_PATH})
message(STATUS "Found LLVM ${LLVM_PACKAGE_VERSION}")
message(STATUS "Using LLVMConfig.cmake in: ${LLVM_DIR}")
message(STATUS "Using MLIRConfig.cmake in: ${MLIR_DIR}")

# Set the compiler flags for LLVM and MLIR headers
add_definitions(${LLVM_DEFINITIONS})

if (TOY_CH STREQUAL "ch1")
    message("Building chapter 1.")
    add_subdirectory(ch1)
else()
    message("Unspecified build target. Doing nothing.")
endif()
