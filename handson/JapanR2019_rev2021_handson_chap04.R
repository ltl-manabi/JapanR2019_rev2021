### Japan.R 2019 初心者セッション 「今日からはじめるR」
### 2021年改訂版 ハンズオン
### 第4章　データの収集 (読み込み)
### Author: タナカケンタ (https://mana.bi/)
### コンテンツやハンズオンの使用方法については、
### https://mana.bi/jr1921 を参照してください。

# -------------------------------------------------------------------------------------
## 4.3　read_csv() 関数によるデータの読み込み

library(readr)
# library(tidyverse) # tidyverseをまるごと読み込んでもよい

df <- read_csv("data/130001_tokyo_covid19_positive_cases_by_municipality.csv")
df # 自動的に表示が省略される

# -------------------------------------------------------------------------------------
## 4.4　readxlパッケージによるExcelファイルの読み込み

library(readxl)
# library(tidyverse) # tidyverseをまるごと読み込んでもよい

# 文部科学省 子供の学び応援サイト掲載コンテンツ情報（オープンデータ）を読み込み
df <- read_excel("data/20201221-mxt_syogai03-000010378_1.xlsx")

df

# -------------------------------------------------------------------------------------
## 4.5　RDBMSとの接続

# パッケージのインストール
install.packages("DBI")
install.packages("RSQLite")

# パッケージの読み込み
library(tidyverse)
library(DBI)
library(RSQLite)

# SQLiteデータベースに接続
db <- dbConnect(SQLite(), "data/stationery.db")

# SQLクエリを発行し、結果を取得する
df <- dbSendQuery(db, "SELECT * FROM 商品マスター") %>% dbFetch()

# 結果の確認
df
