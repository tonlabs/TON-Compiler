set(CMAKE_BUILD_TYPE "RelWithDebInfo" CACHE STRING "")

# TON-Compiler specific options
set(LLVM_EXPERIMENTAL_TARGETS_TO_BUILD   "TVM"         CACHE STRING "")
set(LLVM_TARGETS_TO_BUILD                ""            CACHE STRING "")
set(LLVM_BYTE_SIZE_IN_BITS               257           CACHE STRING "")

set(CLANG_VENDOR                         "TON Labs"    CACHE STRING "")

set(LLVM_INSTALL_TOOLCHAIN_ONLY          ON            CACHE BOOL "")
set(CLANG_ENABLE_ARCMT                   OFF           CACHE BOOL "")
set(BUG_REPORT_URL
  "https://github.com/tonlabs/TON-Compiler/issues"
  CACHE STRING "")

set(LLVM_TOOLCHAIN_TOOLS
  llvm-link
  opt
  llc

  CACHE STRING "")

set(LLVM_DISTRIBUTION_COMPONENTS
  clang
  ${LLVM_TOOLCHAIN_TOOLS}

  tvm-build
  tvm-runtimes
  tvm-supplements
  tvm-cxx-headers
  clang-headers

  CACHE STRING "")
