# Dockerized FEAPpv

[FEAPpv] is a general-purpose educational finite element code
(a light-weight version of [FEAP]).  This repository describes
a [Docker] container for [FEAPpv].

[FEAPpv]: http://projects.ce.berkeley.edu/feap/feappv/

[FEAP]: http://projects.ce.berkeley.edu//feap/

[Docker]: https://www.docker.com/

[DockerHub]: https://hub.docker.com/r/dbindel/feappv-dev/

* * *

2021/4/19

* David Bindel氏のプロジェクトからフォーク。
* リンクが死んでいたため、修正。
* 3.1から5.1へ更新。
* X11サーバーの問題を解決

* * *

## 必要なもの

* git
* Docker(ver.2.5.0.1)
* Xサーバー
* make実行環境（windowsの場合しかしバッチ使用時は不要）

<br>

## 0. Docker、Xサーバー、(make for windows)のインストール

### git clone

* コマンドプロンプトで以下を実行。

```shell
git clone https://github.com/SARDONYX-sard/docker--for-feap.git
```

<br>

### Docker : windows版

windows版Docker2.5.0.1をダウンロード：[ここをクリック](https://desktop.docker.com/win/stable/49550/Docker%20Desktop%20Installer.exe)

インストール時の解説サイト： [こちらのサイト](https://sukkiri.jp/technologies/virtualizers/docker/docker-win_install.html)

<br>

### ホストOS（windows10など）用Xサーバー

windows用：VcXsrv Windows X Serverのダウンロード：[ここをクリック](https://sourceforge.net/projects/vcxsrv/)

インストール時の解説サイト： [こちらのサイト](https://uepon.hatenadiary.com/entry/2020/12/30/005941)

<br>

### make for windows（windowsでmakeコマンドを使いたい場合）

make for windowsをサイトからダウンロード：[ここをクリック](http://gnuwin32.sourceforge.net/packages/make.htm)

インストール時の解説サイト：[Windows10でmakeしたい](https://qiita.com/taki-ikat/items/f501f44a8d44e3fd6987)

windows10の環境変数に`C:\Program Files (x86)\GnuWin32\bin`を追加

<br>

コマンドプロンプトの場合：

```shell
set PATH=%PATH%;C:\Program Files (x86)\GnuWin32\bin
```

* * *

<br>

## 1. Dockerfileからイメージをビルド（feap all auto play  -jpで全自動）

* auto DISPLAY variable translate.batで自動：

  　batchesの中のauto DISPLAY variable translate.batを実行すれば、
    この後行う必要が出る「DISPLAY」の環境変数のパスを通しを自動でやってくれ、
    イメージも自動作成される。

<br>

* コピペして実行する

```sh
docker build -t feappv-dev .
```

> コマンド（cmd）の意味：Dockerfileからfeappv-devという名でイメージを作成

<br>
<br>

* makeコマンドが使える場合：

```bash
make build
```

  または、

```bash
make .PHONY
```

＊ .PHONYの場合はイメージ作成と同時にゴミファイルを掃除してくれる。

* * *

<br>

## 2. feap-devイメージをもとにコンテナーを起動させる。

CLIの例：ソースは自分のフォルダーを選ぶ必要がある。

* 例ではfeappv-dev-dockerフォルダーとUbuntu側のrootフォルダーをシェア。

```sh
docker run --mount type=volume, source==d:/Programing/feappv-dev-docker, target=/feappv/decks feappv-dev
```

> cmdの意味：Dockerイメージからコンテナーを作り、win10フォルダーの中身をUbuntuで認識させる。

<br>

* makeコマンドが使える場合：

git cloneしたフォルダー内の`D:\Programing\feappv-dev-docker`を自分のフォルダパスに変えた後、以下実行

```bash
make run
```

<br>
<br>

GUIの例：

* RUNボタンを押す
  <br>

  ![images](https://github.com/SARDONYX-sard/docker--for-feap/blob/images/docker-img-list.png)

  <br>

* Optional Settingsを押する
  <br>

  ![create container](https://github.com/SARDONYX-sard/docker--for-feap/blob/images/create%20container.png)

  <br>

* コンテナーの名前をつけ、
   volumes
   左はホストOSのfeap-dev-dockerフォルダーのある場所（例　d:/Programing/feappv-dev-docker）、
  右は `/feappv/decks`と記述

  <br>

* RUNを押す
  <br>

  ![container-setting](https://github.com/SARDONYX-sard/docker--for-feap/blob/images/container-setting.png)

  <br>

* コンテナーが立ち上がるのでCLIというところを押す
  <br>

  ![container-list](https://github.com/SARDONYX-sard/docker--for-feap/blob/images/docker-container-list.png)

* * *

<br>

## 3. feapファイル実行を楽にするためにコマンド登録（コンテナー内で）

* <div style= color:red>注意：</div>コンテナーを終了するたびにこのコマンドの登録記録が失われる。
* そのため、コンテナー再起動のたびにこの入力の必要あり。

```sh
alias feap="/feappv/feappv-5.1.1c/main/feappv"
```

> cmdの意味：feapと打つだけで/feappv/feappv-5.1.1c/main/feappvと入力したことになる

![feap-container](https://github.com/SARDONYX-sard/docker--for-feap/blob/images/docker-feap.png)

* * *

<br>

## 4. ipconfigコマンドでWSLのIPv4アドレスを調べる

* バッチを使った自動：
  display IP address.batをクリックしてすると、

```bash
以下をコピペしてコンテナ内に貼り付けてください。

export DISPLAY=172.27.224.1:0.0
alias feap="/feappv/feappv-5.1.1c/main/feappv"

続行するには何かキーを押してください . . .
```

と出るので、コンテナー内に張り付けてEnterを押す。

<br>

* 手動：

ホストOSのコマンドプロンプトで、ipconfigと入力し、実行。

![ip address](https://github.com/SARDONYX-sard/docker--for-feap/blob/images/display-IP-address.png)

* * *

<br>

## 5. パスを通す（コンテナー内）

172.27.224.1の部分は個人によって変わる。
そこに:0.0を付ける。
例：

```sh
export DISPLAY=172.27.224.1:0.0
```

> cmdの意味：環境変数DISPLAYに172.31.48.1:0.0を登録する

* * *

<br>

## 6. feapと入力し、ファイル名を入力する（コンテナー内）

![docker-feap](https://github.com/SARDONYX-sard/docker--for-feap/blob/images/docker-feap.png)

* * *

<br>

## 7. yと入力しEnterを押すとGUIが立ち上がる。

![feap-Xserver](https://github.com/SARDONYX-sard/docker--for-feap/blob/images/feap-Xserver.png)

<br>

* * *

<br>
<br>
<br>

## Makefile内に登録してあるmakeコマンドの解説

<br>

make .PHONY: buildとcleanを両方実行してくれる。
Dockerfileからイメージを作成し、余分ファイル削除

`make run`: イメージを作成後、それをもとにfeappv5_1という名前でコンテナーを起動する。

`make re`: 停止したコンテナーを再び起動させる。

`make build`: feappv-devという名でイメージを作成

`make clean`: iblcokファイル実行時に作成される、Oblockとfeapnameを削除

<br>
## 参考にしたサイト

[The Brain Extension](http://thebrainextension.blogspot.com/2015/01/install-feappv-on-ubuntu-1404.html)

[FEAP Install Mac or Linux (Cygwin too)](https://www.youtube.com/watch?v=_ohQ__rqq3Y)

[Dockerfile だけのRails開発環境](https://qiita.com/aucfan-engineer/items/8a58ef6a8941eb35e2b7)
