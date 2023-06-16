set(TARGET_NAME "${PROJECT_NAME}_ch1")

set(SOURCES
    ${CMAKE_CURRENT_SOURCE_DIR}/parser/AST.cpp
)

set(ENTRYPOINT
    ${CMAKE_CURRENT_SOURCE_DIR}/main.cpp
)

add_executable(${TARGET_NAME}
    ${SOURCES}
    ${ENTRYPOINT}
)

target_include_directories(${TARGET_NAME} PRIVATE
    "${CMAKE_CURRENT_SOURCE_DIR}/include"
    ${LLVM_INCLUDE_DIRS}
)

target_compile_options(${TARGET_NAME} PUBLIC -fno-rtti)

set_target_properties(${TARGET_NAME} PROPERTIES
    CMAKE_EXPORT_COMPILE_COMMANDS ON
    CMAKE_EXPORT_COMPILE_COMMANDS_INCLUDE_DIRS "${TOY_MLIR_INSTALL_PATH}/include"
)

# Link against LLVM libraries
target_link_libraries(${TARGET_NAME} PRIVATE
    LLVMCore
    LLVMIRReader
    LLVMSupport
    MLIRIR
    MLIRParser
    MLIRSupport
)
