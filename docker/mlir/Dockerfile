FROM archlinux:latest

# Install pacman packages
RUN pacman -Syu --noconfirm \
        clang \
        cmake \
        git \
        ninja \
        python \
    && :

# Clone LLVM repository.
RUN git clone --depth 1 --branch llvmorg-16.0.2 https://github.com/llvm/llvm-project.git /llvm-project

# Build MLIR.
WORKDIR /llvm-project/build
ARG BUILD_TYPE='Release'
ARG INSTALL_PATH='/mlir'
RUN mkdir -p ${INSTALL_PATH} \
    && cmake -G Ninja ../llvm \
        -DCMAKE_BUILD_TYPE=${BUILD_TYPE} \
        -DCMAKE_INSTALL_PREFIX=${INSTALL_PATH} \
        -DLLVM_ENABLE_PROJECTS=mlir \
        -DLLVM_TARGETS_TO_BUILD="X86;NVPTX" \
    && cmake --build . --target install
