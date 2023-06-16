# Location of this Makefile.
ROOT = $(abspath $(shell dirname "${MAKEFILE_LIST}"))

# CMake build artifacts.
BUILD_DIR = ${ROOT}/build
CH1_BUILD_DIR = ${BUILD_DIR}/ch1
CH2_BUILD_DIR = ${BUILD_DIR}/ch2

# MLIR installation path. This path exists in the Docker development container.
MLIR_PATH = '/mlir'

# Build chapter 1.
ch1:
	mkdir -p "${CH1_BUILD_DIR}" \
	&& cd "${CH1_BUILD_DIR}" \
	&& cmake "${ROOT}" \
		-DCMAKE_BUILD_TYPE=Debug \
		-DCMAKE_RUNTIME_OUTPUT_DIRECTORY="${CH1_BUILD_DIR}" \
		-DTOY_CH=ch1 \
		-DTOY_MLIR_EXTERNAL_PATH="${MLIR_PATH}" \
		-GNinja \
	&& ninja

# Build chapter 2.
ch2:
	mkdir -p "${CH2_BUILD_DIR}" \
	&& cd "${CH2_BUILD_DIR}" \
	&& cmake "${ROOT}" \
		-DCMAKE_BUILD_TYPE=Debug \
		-DCMAKE_RUNTIME_OUTPUT_DIRECTORY="${CH2_BUILD_DIR}" \
		-DTOY_CH=ch2 \
		-DTOY_MLIR_EXTERNAL_PATH="${MLIR_PATH}" \
		-GNinja \
	&& ninja

# Delete build artifacts.
distclean:
	rm -fr "${BUILD_DIR}"

.PHONY:        \
	ch1        \
	ch2        \
	distclean
