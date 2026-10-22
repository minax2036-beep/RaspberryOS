.section .text.boot, "ax"
.global _start
.type _start, %function

_start:
    // CPU 0 以外は待機
    mrs     x1, mpidr_el1
    and     x1, x1, #0xff
    cbnz    x1, .Lpark

    // ファームウェアから渡された DTB アドレスを保存
    mov     x19, x0

    // スタックを設定
    ldr     x1, =__stack_top
    mov     sp, x1

    // BSS 領域をゼロ初期化
    ldr     x1, =__bss_start
    ldr     x2, =__bss_end

.Lclear_bss:
    cmp     x1, x2
    b.hs    .Lbss_done
    str     xzr, [x1], #8
    b       .Lclear_bss

.Lbss_done:
    // kernel_main の第1引数に DTB アドレスを渡す
    mov     x0, x19
    bl      kernel_main

.Lpark:
    wfe
    b       .Lpark

.size _start, . - _start

.section .bss.stack, "aw", %nobits
.balign 4096
.global __stack_bottom
__stack_bottom:
    .skip 65536
.global __stack_top
__stack_top:
