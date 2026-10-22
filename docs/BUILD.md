# ビルド手順

## 対象環境

Debian / Ubuntu 系 Linux を想定する。まずクロスコンパイラーと binutils をインストールする。

```sh
sudo apt update
sudo apt install -y make binutils-aarch64-linux-gnu gcc-aarch64-linux-gnu g++-aarch64-linux-gnu
```

## ビルド

リポジトリのルートで実行する。

```sh
make clean
make
```

成功すると build/kernel.elf と build/kernel_2712.img が生成される。

## 現時点での制限

- これはクロスコンパイルの確認であり、実機起動の保証ではない。
- UART、ディスプレイ、キーボード、Device Tree の解析は未実装。
- 初期カーネルは CPU 0 で待機ループに入るだけで、画面に表示は出ない。
- 生成されたイメージを普段使いの microSD に直接書き込まない。

## 次の検証

次段階で Raspberry Pi 5 の起動条件、CPU の初期状態、Device Tree の受け渡し、診断出力方法を確認し、実機向けのテスト手順を別途文書化する。
