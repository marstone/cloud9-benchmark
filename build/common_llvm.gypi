#
# Cloud9 Parallel Symbolic Execution Engine
# 

{
  'variables': {
    'make_clang_dir%': '../../../llvm/llvm-3.1/Release+Asserts',
    'binutils_gold_dir%': '../../../binutils/build',
    'llvm_gold_plugin%': '../../../llvm/llvm-3.1/Release+Asserts/lib/LLVMgold.so',
  },
  'make_global_settings=': [
    # TODO(bucur): Hack, hack, hack. The Makefile gyp generator prepends the
    # current path to all parameters not prefixed by '$', including flag names.
    # As a workaround, we prefix each flag with $(Empty).
    ['Empty', ' '],
    ['CC', '<(make_clang_dir)/bin/clang'],
    ['CXX', '<(make_clang_dir)/bin/clang++'],
    ['LINK', '$(CXX)'],
    ['CC.host', '$(CC)'],
    ['CXX.host', '$(CXX)'],
    ['LINK.host', '$(LINK)'],
    ['ARFLAGS.target', '$(Empty)-cru'],
  ], # make_global_settings
  'target_defaults': {
    'defines': [
      '_FILE_OFFSET_BITS=32',
    ],
  },
}
