# minecraft-server-alpha

Minecraftインストール手順書

## Usage

### 起動

Minecraftサーバ、nginx起動

```bash
docker-compose up
```

ゲームを開始し、一通りマップ生成後、下記コマンドでoverviewerのマップデータ作成

```bash
./build-map.sh
```

http://localhost:8080 にアクセスしマップを閲覧

### 終了

rcon経由で終了させる

```bash
# minecraftコンテナへアタッチ
docker-compose exec mc rcon-cli stop
```

## Requirements

* Minecraft 1.12.2
* forge-1.12.2-14.23.5.2768
* Aether Legacy 1.12.2-v1.4.4
* Minecraft overviewer
* nginx
* Docker version 19.03.0-beta3, build c55e026
* docker-compose version 1.23.2, build 1110ad01

## Installation

### クライアント

Windowsを想定

* Minecraft Launcherを [PCおよびMac用に購入する | Minecraft](https://my.minecraft.net/ja-jp/store/minecraft/#owned "PCおよびMac用に購入する | Minecraft") からダウンロード
* ランチャーを起動して、バージョンを`1.12.2`に変更し、一度Minecraft本体を起動
* Minecraftを終了
* Minecraft Forge 1.12.2 をインストール
    * インストーラーを [Minecraft Forge](https://files.minecraftforge.net/ "Minecraft Forge") からダウンロード
        * Download Recommended 1.12.2 - 14.23.5.2768 > Windows Installer をダウンロード
    * インストール手順
        * 特に変更なし、OKを押す
* Minecraft Launcherを起動
* 「起動オプション」タブ > 新規作成
    * 下記設定で起動プロファイルを新規作成
    * 名前: `test` <任意の名前で良い>
    * バージョン: `release 1.12.2-forge1.12.2-14.23.5.2768`
* 「ニュース」タブに戻り、プレイボタン右側オプションボタン押下
* 先程作成したプロファイル`test`を選択し、起動
* 正常に起動できるか確かめる
* Minecraftを終了
* Modのインストール
    * Aether Legacy 1.12.2 modを  [Aether Legacy 1.12.2-v1.4.4 - Files - The Aether - Mods - Projects - Minecraft CurseForge](https://minecraft.curseforge.com/projects/the-aether/files/2698950 "Aether Legacy 1.12.2-v1.4.4 - Files - The Aether - Mods - Projects - Minecraft CurseForge") からダウンロード
    * `<ゲームディレクトリ>`を下記の手順で確認
        * Minecraft Launcher起動 > 「起動オプション」タブ > test (任意の名前) > ゲームディレクトリ
    * 下記パスとなるように`aether_legacy-1.12.2-v1.4.4.jar`を設置
        * `<ゲームディレクトリ>\mods\aether_legacy-1.12.2-v1.4.4.jar`
        * デフォルトでは下記の位置？
            * `%APPDATA%\Roaming\.minecraft\<forge-version>\mods\aether_legacy-1.12.2-v1.4.4.jar`
* Minecraft Launcherを起動
* プロファイルtestを選択し、Minecraft本体を起動
* タイトル画面でModsボタンを押下し、Aether modが読み込まれていることを確認


#### 参考

* [(28) How to INSTALL Aether Legacy (With Forge)! [Minecraft 1.12.2+] - YouTube](https://www.youtube.com/watch?v=ZMoXj9VTae0 "(28) How to INSTALL Aether Legacy (With Forge)! [Minecraft 1.12.2+] - YouTube")


### サーバ

* 下記ファイルをダウンロードし、scp等でサーバへ送付
    * `aether_legacy-1.12.2-v1.4.4.jar`
        * [Aether Legacy 1.12.2-v1.4.4 - Files - The Aether - Mods - Projects - Minecraft CurseForge](https://minecraft.curseforge.com/projects/the-aether/files/2698950 "Aether Legacy 1.12.2-v1.4.4 - Files - The Aether - Mods - Projects - Minecraft CurseForge") からダウンロード
    * `forge-1.12.2-14.23.5.2768-installer.jar`
        * [Minecraft Forge](https://files.minecraftforge.net/ "Minecraft Forge") からダウンロード
            * Download Recommended 1.12.2 - 14.23.5.2768 > Installer を選択

```bash
git clone https://github.com/rmatttu/minecraft-server-alpha.git
cd minecraft-server-alpha
# `aether_legacy-1.12.2-v1.4.4.jar` をscp等で設置
# `forge-1.12.2-14.23.5.2768-installer.jar` をscp等で設置
mv forge-1.12.2-14.23.5.2768-installer.jar data/
mv aether_legacy-1.12.2-v1.4.4.jar data/mods/
docker-compose up
```

#### 参考

* Forge installerを環境変数に指定しているので、自動的にインストールされる
    * [dockerfiles/minecraft-server at master · itzg/dockerfiles](https://github.com/itzg/dockerfiles/tree/master/minecraft-server#running-a-forge-server "dockerfiles/minecraft-server at master · itzg/dockerfiles")


## Backup

dataを.tar.xzに固め、dropboxへアップロードします

```bash
git clone https://github.com/andreafabrizi/Dropbox-Uploader
cd Dropbox-Uploader/
./dropbox_uploader.sh
```

[LinuxのコマンドラインでDropboxにファイルをアップロードしてみた – bgbgbg](https://blog.bgbgbg.net/archives/2507)
を参考にセットアップ

バックアップを実行したいときに、下記スクリプトを実行

```bash
./backup.sh
```


## Memo

* Aether 2 はクラッシュ頻発？orbis関連のエラーで落ちているようだった。どのバージョンを使用すればいいのかわからない。
* Minecraft Launcher version
    * 2.1.3674 | Tue, 23 Apr 2019 08:35:33 GMT | fafa322bd04a73d6e9d87f418eb59d929720d720
* クライアント、メモリに余裕がある場合
    * JVMの引数: `-Xmx8G -XX:+UnlockExperimentalVMOptions -XX:+UseG1GC -XX:G1NewSizePercent=20 -XX:G1ReservePercent=20 -XX:MaxGCPauseMillis=50 -XX:G1HeapRegionSize=64M`
* [サーバ設定ファイル(server.properties) | minecraft.server-memo.net](https://minecraft.server-memo.net/server-properties/ "サーバ設定ファイル(server.properties) | minecraft.server-memo.net")

