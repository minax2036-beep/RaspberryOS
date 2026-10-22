#include <cstdint>

extern "C" [[noreturn]] void kernel_main(std::uint64_t device_tree_address) {
    // ファームウェアから渡される DTB アドレスは後続段階で解析する。
    // 現段階では UART / 画面ドライバーが未実装のため、ログ出力は行わない。
    (void)device_tree_address;
    for (;;) {
        asm volatile("wfe");
    }
}
