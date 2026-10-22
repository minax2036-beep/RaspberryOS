TOOLCHAIN ?= aarch64-linux-gnu-
CXX := $(TOOLCHAIN)g++
LD := $(TOOLCHAIN)ld
OBJCOPY := $(TOOLCHAIN)objcopy
BUILD_DIR := build
KERNEL_ELF := $(BUILD_DIR)/kernel.elf
KERNEL_IMG := $(BUILD_DIR)/kernel_2712.img
COMMON_FLAGS := -mcpu=cortex-a76 -ffreestanding -fno-exceptions -fno-rtti -fno-stack-protector -fno-pic -mgeneral-regs-only -Wall -Wextra -Werror -O2
CXXFLAGS := $(COMMON_FLAGS) -std=c++20 -Ikernel/include
ASFLAGS := $(COMMON_FLAGS)
LDFLAGS := -T linker.ld -nostdlib
OBJECTS := $(BUILD_DIR)/boot.o $(BUILD_DIR)/kernel.o

.PHONY: all clean
all: $(KERNEL_IMG)

$(BUILD_DIR):
	mkdir -p $@

$(BUILD_DIR)/boot.o: kernel/arch/aarch64/boot.S | $(BUILD_DIR)
	$(CXX) $(ASFLAGS) -c $< -o $@

$(BUILD_DIR)/kernel.o: kernel/core/kernel.cpp | $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) -c $< -o $@

$(KERNEL_ELF): $(OBJECTS) linker.ld
	$(LD) $(LDFLAGS) -o $@ $(OBJECTS)

$(KERNEL_IMG): $(KERNEL_ELF)
	$(OBJCOPY) -O binary $< $@
	@echo Built $@ - hardware boot not yet verified

clean:
	rm -rf $(BUILD_DIR)
