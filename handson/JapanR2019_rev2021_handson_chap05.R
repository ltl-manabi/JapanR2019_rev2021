### Japan.R 2019 初心者セッション 「今日からはじめるR」
### 2021年改訂版 ハンズオン
### 第5章　データの観察
### Author: タナカケンタ (https://mana.bi/)
### コンテンツやハンズオンの使用方法については、
### https://mana.bi/jr1921 を参照してください。

# -------------------------------------------------------------------------------------
## 5.3　DataExplorerパッケージによるEDA

# パッケージのインストール
install.packages(DataExplorer)

# パッケージの読み込み
library(tidyverse)
library(DataExplorer)

df <- read_csv("data/130001_tokyo_covid19_positive_cases_by_municipality.csv")

# データフレームについてのレポートを出力
create_report(df, output_dir = "report")

# -------------------------------------------------------------------------------------
## 5.4　ExPanDパッケージによるEDA

# パッケージのインストール
install.packages(ExPanDaR)

# パッケージの読み込み
library(tidyverse)
library(ExPanDaR)

# データの読み込み
df <- read_csv("data/130001_tokyo_covid19_positive_cases_by_municipality.csv")

# レポート画面の起動
# Ctrl + cキーで終了
# レポートをRファイルとして出力できる
ExPanD(df, export_nb_option = TRUE)

# -------------------------------------------------------------------------------------
## 5.5　skimrパッケージによる基本統計量の算出

# パッケージのインストール
install.packages("skimr")

# パッケージの読み込み
library(tidyverse)
library(skimr)

# データの読み込み
df <- read_csv("data/130001_tokyo_covid19_positive_cases_by_municipality.csv")

# 基本統計量の算出
skim(df)

# -------------------------------------------------------------------------------------
## 5.6　ggplot2パッケージによる可視化

library(tidyverse)

df <- read_csv("data/130001_tokyo_covid19_positive_cases_by_municipality.csv")

# 陽性者数の累積を棒グラフでプロット
ggplot(df, aes(x = 公表_年月日, y = 陽性者数)) +
    geom_bar(stat = "identity") +
    scale_x_date(breaks = "3 month") +
    ggtitle("東京都の陽性者数 (累積)")

# 区の順番を全国地方公共団体コードに合わせる
df[["市区町村名"]] <- factor(df[["市区町村名"]])

df <- df %>% mutate(市区町村名 = fct_reorder(市区町村名, 全国地方公共団体コード))

# データから23区のみを抽出、前日の値を引いて陽性者数の前日比を算出する
filtered_df <- df %>%
                filter(str_detect(市区町村名, "区$")) %>%
                mutate(市区町村名 = fct_drop(市区町村名)) %>%
                group_by(市区町村名) %>%
                mutate(陽性者数前日比 = 陽性者数 - lag(陽性者数))

# 陽性者数の推移を区ごとに棒グラフでプロット
ggplot(filtered_df, aes(x = 公表_年月日, y = 陽性者数前日比, group = 市区町村名)) +
    geom_bar(stat = "identity") +
    scale_x_date(breaks = "3 month", date_labels = "%m") +
    lims(y = c(0, 200)) +
    facet_wrap(~ 市区町村名, ncol = 8) +
    ggtitle("東京都23区ごとの陽性者数の推移") +
    theme_minimal()
