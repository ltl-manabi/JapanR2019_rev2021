### Japan.R 2019 初心者セッション 「今日からはじめるR」
### 2021年改訂版 ハンズオン
### 第3章　パッケージ
### Author: タナカケンタ (https://mana.bi/)
### コンテンツやハンズオンの使用方法については、
### https://mana.bi/jr1921 を参照してください。

# -------------------------------------------------------------------------------------
## 3.2　パッケージの読み込み

library(foreign) # foreignパッケージを読み込む
# SPSS形式のファイルを読み込む
# データ出典: https://study.sagepub.com/aldrich3e/student-resources/ibm%C2%AE-spss-%C2%AE-sample-files
df <- read.spss("data/advert.sav", to.data.frame = TRUE)
df

# -------------------------------------------------------------------------------------
## 3.3　パッケージのインストール

# 統計教育のためのサンプルパッケージをインストールする
install.packages("TeachingDemos")

library(TeachingDemos) # パッケージの読み込み
# サイコロを3つ振る行為を3回繰り返し、結果をプロットする関数を実行する
# 実行するたびに結果が変わる
dice(rolls = 3, ndice = 3, plot.it = TRUE)

# -------------------------------------------------------------------------------------
## 3.5　GitHubからのインストール

install.packages("remotes") # パッケージのインストール

library(remotes) # パッケージの読み込み
# 動画作成者による「何もしない」パッケージをインストール
install_github("ltl-manabi/nothing")

library(nothing) # パッケージの読み込み
hello() # ただ、「Hello, World!」と出力するだけの関数を実行

# -------------------------------------------------------------------------------------
## 3.6　tidyverseパッケージ群について

install.packages("tidyverse")

library(tidyverse) # パッケージの読み込み
tidyverse_packages() # tidyverseに含まれるパッケージの一覧を出力
