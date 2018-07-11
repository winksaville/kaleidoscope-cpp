#clang_dist_dir := ../mkclang/dist
#clang_bin_dir := $(clang_dist_dir)/bin/
#clang_lib_dir := $(clang_dist_dir)/lib/
build-type := release
llvm_cflags := $(shell $(clang_bin_dir)llvm-config --cxxflags)
#llvm_cflags += -static
linker := lld
#llvm_lflags := -static $(shell $(clang_bin_dir)llvm-config --ldflags --system-libs --libs)
llvm_lflags :=
v :=

build_cflags_common := -g

ifeq ($(build-type),release)
  build_cflags := -O2 $(build_cflags_common)
else ifeq ($(build-type),debug)
  build_cflags := -O0 $(build_cflags_common)
else
  $(error Unknown build-type, expecting build-type=release|debug)
endif
  
ifeq ($(v),)
  silent := @
else ifeq ($(v),false)
  silent := @
else
  silent :=
  build_cflags += -v
endif

#$(warning build-type=$(build-type))
#$(warning clang_bin_dir=$(clang_bin_dir))
#$(warning linker=$(linker))
#$(warning llvm_cflags=$(llvm_cflags))
#$(warning build_cflags=$(build_cflags))

all: toy.$(build-type)

toy.$(build-type): toy.$(build-type).o Makefile
	$(silent)$(clang_bin_dir)clang++ $(llvm_lflags) toy.$(build-type).o -o toy.$(build-type)
	$(silent)objdump -S -d -M intel toy.$(build-type) > toy.$(build-type).asm

toy.$(build-type).o: toy.cpp Makefile
	$(silent)$(clang_bin_dir)clang++ $(llvm_cflags) $(build_cflags) -c toy.cpp -o toy.$(build-type).o
	$(silent)objdump -S -d -M intel toy.$(build-type).o > toy.$(build-type).o.asm

.PHONY: clean
clean:
	$(silent)rm -f toy.debug toy.release toy.*.o

.PHONY: distclean
distclean: clean
	$(silent)rm -f toy.*.asm
