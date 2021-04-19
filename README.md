# Dockerized FEAPpv

[FEAPpv] is a general-purpose educational finite element code
(a light-weight version of [FEAP]).  This repository describes
a [Docker] container for [FEAPpv].

[FEAPpv]: http://projects.ce.berkeley.edu/feap/feappv/

[FEAP]: http://projects.ce.berkeley.edu//feap/

[Docker]: https://www.docker.com/

[DockerHub]: https://hub.docker.com/r/dbindel/feappv-dev/

2021/4/19
David Bindel氏のプロジェクトからフォーク。
リンクが死んでいたため、修正。
3.1から5.1へ更新。

* X11サーバーの問題を解決するため、Linuxとwin10双方にxserver-xorgを入れる必要あり。

## 使用方法：Dockerfileを基にビルドして、runで実行する

### 1. ビルドコマンドを実行

＊注：

* 最後の「.」を忘れない。
* 「.」の前に半角スペース。

```sh
docker build -t feappv5_1 .
```

コマンド（以下cmdと略）の意味：Dockerfileからイメージを作成

### 2. GUIまたはGLIから実行させる。GUIがオススメ

CLIの例：ソースは自分のフォルダーを選ぶ必要がある。

* 例ではfeappv-dev-dockerフォルダーとUbuntu側のrootフォルダーを同期させている。

```sh
docker run --mount type=volume, source==d:/Programing/feappv-dev-docker, target=/root feappv5_1
```

cmdの意味：Dockerイメージからコンテナーを作り、win10フォルダーの中身をUbuntuで認識させる。

### 3. feapファイル実行を楽にするためにコマンド登録

* 注意：コンテナーを終了するたびにこのコマンドの登録記録が失われる。
* そのため、コンテナー再起動のたびにこの入力の必要あり。

```sh
alias feap="/feappv/feappv-5.1.1c/main/feappv"
```

cmdの意味：feapと打つだけで/feappv/feappv-5.1.1c/main/feappvと入力したことになる

### 4. ipconfigコマンドでWSLのIPアドレスを調べてパスを通す

例：172.31.48.1の部分は個人によって変わる。 そこに:0.0を付ける。

```sh
export DISPLAY=172.31.48.1:0.0
```

cmdの意味：環境変数DISPLAYに172.31.48.1:0.0を登録する

### 5. ホストOS（筆者環境：windows10）とUbuntuにXサーバーをインストール

windows用：[VcXsrv Windows X Server](https://sourceforge.net/projects/vcxsrv/)
Ubuntu用：このサイト[WSL2環境で動作するDockerを使用してX Window SystemのGoogle Chromeブラウザを動作させる](https://uepon.hatenadiary.com/entry/2020/12/30/005941)の解説を見ながら以下のコマンドを入力。

```sh
apt update
apt install xserver-xorg x11-apps
```
