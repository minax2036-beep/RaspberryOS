# RaspberryOS

RaspberryOS は、Raspberry Pi 5 向けに開発する独自カーネルベースの OS プロジェクトです。Linux カーネルを土台にせず、C++ と必要最小限の AArch64 アセンブリで段階的に実装します。

> **現在の段階：Milestone 0 — ビルド可能なカーネル骨格**
>
> 現時点では実機起動・画面表示・入力・アプリ実行は未確認です。CI のビルド成功と実機動作確認を区別します。

## 方針

- 対象：Raspberry Pi 5（BCM2712 / AArch64）
- カーネル：独自実装。初期段階では OS ランタイムに依存しない
- 主言語：C++、起動などに必要な部分のみ AArch64 アセンブリ
- 最初の目標：起動経路を確立し、段階的に診断出力と文字コンソールを実装
- 将来の目標：シェル、ファイルシステム、アプリ起動管理、独自 .xid 形式、ユーザーがカスタマイズできるシステム
- 文書：Markdown は日本語で記述

## ビルド

Debian / Ubuntu 系の Linux で必要なツールを導入します。

```sh
sudo apt update
sudo apt install -y make binutils-aarch64-linux-gnu gcc-aarch64-linux-gnu g++-aarch64-linux-gnu
make
```

生成物は build/kernel_2712.img です。これは初期の生バイナリであり、現段階では起動成功を保証しません。

## ドキュメント

- [基本仕様書](docs/SPECIFICATION.md)
- [ビルド手順](docs/BUILD.md)

## 安全な実機テスト

既存の Raspberry Pi OS の起動ファイルを上書きしないでください。まず別の microSD カードを使い、必要なファームウェアファイルを保持したテスト用メディアで確認します。現段階では実機テスト手順を確定する前に、起動条件と診断出力方式を検証します。
