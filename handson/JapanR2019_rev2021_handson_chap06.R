### Japan.R 2019 初心者セッション 「今日からはじめるR」
### 2021年改訂版 ハンズオン
### 第6章　データの加工
### Author: タナカケンタ (https://mana.bi/)
### コンテンツやハンズオンの使用方法については、
### https://mana.bi/jr1921 を参照してください。

# -------------------------------------------------------------------------------------
## 6.2.1　select() 関数による列の選択

library(tidyverse)

df <- read_csv("data/130001_tokyo_covid19_positive_cases_by_municipality.csv")

# 列名を列挙して選択
selected_df <- select(df, 公表_年月日, 市区町村名, 陽性者数)
head(selected_df)

# パイプを使った選択
df %>% select(公表_年月日, 市区町村名, 陽性者数) %>% head()

# -------------------------------------------------------------------------------------
## 6.2.2　filter() 関数による行の抽出

# 2021年4月1日以降のレコードだけ抽出
df %>% filter(公表_年月日 >= "2021-04-01") %>% head()

# 港区のレコードだけ抽出
df %>% filter(市区町村名 == "港区") %>% head()

# 「〇〇村」のレコードだけ抽出
# 正規表現で "村$" としないと、東村山市なども抽出される
df %>% filter(str_detect(市区町村名, "村$")) %>% head()

# -------------------------------------------------------------------------------------
## 6.2.3　mutate() 関数による列の追加

# データが累積なので、前日の値を引いて陽性者数の前日比を算出する
mutated_df <- df %>% group_by(市区町村名) %>% mutate(陽性者数前日比 = 陽性者数 - lag(陽性者数))
tail(mutated_df, 100)

# -------------------------------------------------------------------------------------
## 6.2.4　summarise() 関数による要約

# 区ごと、月別に、毎日何人の陽性者が発表されるかの平均を算出
summarised_df <- mutated_df %>%
                    filter(str_detect(市区町村名, "区$")) %>%
                    mutate(公表_年月 = format(公表_年月日, "%y-%m")) %>%
                    group_by(市区町村名, 公表_年月) %>%
                    summarise(月別平均陽性者数前日比 = mean(陽性者数前日比, na.rm = TRUE))

# 港区のレコードを抽出
filter(summarised_df, 市区町村名 == "港区")

# -------------------------------------------------------------------------------------
## 6.3　recipesパッケージによるデータの加工

install.packages("tidymodels")

library(tidymodels)

# 標準添付のairqualityデータセットを使用する
# Month列をfactor型に変換し、Day列を取り除く
aq_df <- airquality %>% select(-Day) %>% mutate(Month = as.factor(Month))

# データを学習用と検証用に分割する
# データの分割割合を指定
split_ratio <- initial_split(aq_df, prop = 0.8)

# 学習用データをサンプリング
df_train <- training(split_ratio)

# 検証用データをサンプリング
df_test <- testing(split_ratio)

# データに対して、数値の標準化と欠損値の除去を行うレシピを定義
rec <- df_train %>%
  recipe(Ozone ~ .) %>%
  step_naomit(all_predictors(), all_outcomes()) %>%
  step_normalize(all_predictors(), -Month)

# レシピを実行
res_df_train <- rec %>% prep() %>% juice()
res_df_test <- rec %>% prep() %>% bake(new_data = df_test)

head(res_df_train)
head(res_df_test)
