.section .text.boot, "ax"
.global _start
.type _start, %function
_start:
    // 初期版では CPU 0 のみを使用し、他の CPU は待機させる。
    mrs     x1, mpidr_el1
    and     x1, x1, #0xff
    cbnz    x1, .Lpark
    ldr     x1, =__stack_top
    mov     sp, x1
    bl      kernel_main
.Lpark:
    wfe
    b       .Lpark
.size _start, . - _start
.section .bss.stack, "aw", %nobits
.align 12
.global __stack_bottom
__stack_bottom:
    .skip 65536
.global __stack_top
__stack_top:
