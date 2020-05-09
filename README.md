[![Gem Version](https://badge.fury.io/rb/histock-simplefilter.svg)](https://badge.fury.io/rb/histock-simplefilter)
[![Build Status](https://travis-ci.org/ysato5654/histock-simplefilter.svg?branch=master)](https://travis-ci.org/ysato5654/histock-simplefilter)
[![Coverage Status](https://coveralls.io/repos/github/ysato5654/histock-simplefilter/badge.svg?branch=master)](https://coveralls.io/github/ysato5654/histock-simplefilter?branch=master)

# Histock::Simplefilter

histock-simplefilter is Ruby library to get the finance data of listed stock on the Taiwan stock exchange market from [HiStock嗨投資理財社群](https://histock.tw/).
The library provides you to basic output data.

If you would like to get more organized data, refer to [histock-filter](https://github.com/ysato5654/histock-filter).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'histock-simplefilter'
```

And then execute:

```
$ bundle install
```

Or install it yourself as:

```
$ gem install histock-simplefilter
```

## Usage

### Basic Financial Statements (基本財報)

#### Monthly Revenue (每月營收)

```rb
require 'histock/simplefilter'

histock = Histock::Simplefilter.new
histock.monthly_revenue('2330') # code '2330' is TSMC
# [
#   ["年度/月份", "單月營收", "去年同月營收", "單月月增率", "單月年增率", "累計營收", "去年累計營收", "累積年增率"],
#   ["2020/04", "96,001,568", "74,693,616", "-15.4%", "28.5%", "406,598,784", "293,398,112", "38.6%"],
#   ["2020/03", "113,519,600", "79,721,584", "21.5%", "42.4%", "310,597,184", "218,704,496", "42%"],
#   ["2020/02", "93,394,448", "60,889,060", "-9.9%", "53.4%", "197,077,600", "138,982,896", "41.8%"],
#   ["2020/01", "103,683,104", "78,093,824", "0.3%", "32.8%", "103,683,104", "78,093,824", "32.8%"],
#   ["2019/12", "103,313,104", "89,830,600", "-4.2%", "15%", "1,069,985,024", "1,031,473,984", "3.7%"],
#   ["2019/11", "107,884,400", "98,389,424", "1.7%", "9.6%", "966,672,320", "941,642,880", "2.7%"],
#   ["2019/10", "106,039,504", "101,550,200", "3.8%", "4.4%", "858,787,904", "843,253,632", "1.8%"],
#   ["2019/09", "102,170,096", "94,921,920", "-3.7%", "7.6%", "752,748,416", "741,703,424", "1.5%"],
#   ["2019/08", "106,117,600", "91,055,040", "25.2%", "16.5%", "650,578,304", "646,781,376", "0.6%"],
#   ["2019/07", "84,757,728", "74,370,928", "-1.3%", "14%", "544,460,672", "555,726,400", "-2%"],
#   ["2019/06", "85,867,928", "70,438,304", "6.8%", "21.9%", "459,702,912", "481,355,488", "-4.5%"],
#   ["2019/05", "80,436,928", "80,968,736", "7.7%", "-0.6%", "373,835,008", "410,917,184", "-9%"]
# ]
```

#### Income Statement (損益表)

```rb
require 'histock/simplefilter'

histock = Histock::Simplefilter.new
histock.income_statement('2330') # code '2330' is TSMC
# [
#   ["年度/季別", "營收", "毛利", "營業利益", "稅前淨利", "稅後淨利"],
#   ["2019Q4", "317,237,065", "159,240,985", "124,243,722", "128,781,973", "116,078,194"],
#   ["2019Q3", "293,045,439", "139,432,161", "107,887,292", "112,336,271", "101,102,454"],
#   ["2019Q2", "240,998,475", "103,673,230", "76,304,053", "80,545,440", "66,775,851"],
#   ["2019Q1", "218,704,469", "90,352,125", "64,266,023", "68,181,652", "61,387,310"],
#   ["2018Q4", "289,770,193", "138,042,400", "107,123,251", "111,082,092", "100,005,385"],
#   ["2018Q3", "260,347,882", "123,380,843", "95,245,181", "98,896,942", "89,098,072"],
#   ["2018Q2", "233,276,811", "111,588,104", "84,428,146", "87,587,608", "72,293,375"],
#   ["2018Q1", "248,078,671", "124,974,694", "96,826,946", "99,943,621", "89,787,574"]
# ]
```

### Dividend Policy (股利政策)

#### 除權除息

```rb
require 'histock/simplefilter'

histock = Histock::Simplefilter.new
histock.dividend_policy('2330') # code '2330' is TSMC
# [
#   ["所屬年度", "發放年度", "除權日", "除息日", "除權息前股價", "股票股利", "現金股利", "EPS", "配息率", "現金殖利率", "扣抵稅率", "增資配股率", "增資認購價"],
#   ["2019", "2020", "", "06/18", "297.5", "0", "2.5", "13.32", "0.1877", "0.0084", "0", "0", "0"],
#   ["2019", "2020", "", "03/19", "260", "0", "2.5", "13.32", "0.1877", "0.0096", "0", "0", "0"],
#   ["2018", "2019", "", "12/19", "344.5", "0", "2.5", "13.54", "0.1846", "0.0073", "0", "0", "0"],
#   ["2018", "2019", "", "09/19", "267", "0", "2", "13.54", "0.1477", "0.0075", "0", "0", "0"],
#   ["2018", "2019", "", "06/24", "248.5", "0", "8", "13.54", "0.5908", "0.0322", "0", "0", "0"],
#   ["2017", "2018", "", "06/25", "227.5", "0", "8", "13.23", "0.6047", "0.0352", "0", "0", "0"],
#   ["2016", "2017", "", "06/26", "217", "0", "7", "12.89", "0.5431", "0.0323", "0.1394", "0", "0"],
#   ["2015", "2016", "", "06/27", "159", "0", "6", "11.82", "0.5076", "0.0377", "0.1257", "0", "0"],
#   ["2014", "2015", "", "06/29", "146", "0", "4.5", "10.18", "0.442", "0.0308", "0.1113", "0", "0"],
#   ["2013", "2014", "", "07/14", "136.5", "0", "3", "7.26", "0.4132", "0.022", "0.0978", "0", "0"],
#   ["2012", "2013", "", "07/03", "110", "0", "3", "6.41", "0.468", "0.0273", "0.0775", "0", "0"],
#   ["2011", "2012", "", "07/04", "84.2", "0", "3", "5.18", "0.5792", "0.0356", "0.0669", "0", "0"],
#   ["2010", "2011", "", "06/29", "72.5", "0", "3", "6.24", "0.4808", "0.0414", "0.0496", "0", "0"],
#   ["2009", "2010", "", "07/06", "61.4", "0", "3", "3.45", "0.8696", "0.0489", "0.0985", "0", "0"],
#   ["2008", "2009", "07/15", "07/15", "55.8", "0.05", "3", "3.86", "0.7772", "0.0538", "0", "0", "0"],
#   ["2007", "2008", "07/16", "07/16", "55.8", "0.05", "3.03", "-", "-", "0", "0.0186", "0.02", "0"]
# ]
```

### Profitability (獲利能力)

#### Profit Ratio (利潤比率)

```rb
require 'histock/simplefilter'

histock = Histock::Simplefilter.new
histock.profit_ratio('2330') # code '2330' is TSMC
```

#### Income Rate (報酬率)

```rb
require 'histock/simplefilter'

histock = Histock::Simplefilter.new
# monthly data
histock.income_rate('2330', 'month') # code '2330' is TSMC
# quarterly data
histock.income_rate('2330', 'quarter')
# yearly data
histock.income_rate('2330', 'year')
```

### Request Lists (Method)

| Category | Request (Ch) | Request (En) | Source URL |
|--|--|--|--|
| 基本財報 | 每月營收 | Monthly Revenue | https://histock.tw/stock/financial.aspx?no=CODE&t=1&st=1 |
| 基本財報 | 損益表 | Income Statement | https://histock.tw/stock/financial.aspx?no=CODE&t=1&st=4 |
| 股利政策 | 除權除息 |  | https://histock.tw/stock/financial.aspx?no=CODE&t=2 |
| 獲利能力 | 利潤比率 | Profit Ratio | https://histock.tw/stock/financial.aspx?no=CODE&t=3&st=1 |
| 獲利能力 | 報酬率(單一季) | Income Rate | https://histock.tw/stock/financial.aspx?no=CODE&t=3&st=2&q=1 |
| 獲利能力 | 報酬率(近四季) | Income Rate | https://histock.tw/stock/financial.aspx?no=CODE&t=3&st=2&q=2 |
| 獲利能力 | 報酬率(年度) | Income Rate | https://histock.tw/stock/financial.aspx?no=CODE&t=3&st=2&q=3 |

(note) You can fill real code number in 'CODE' field.
