require 'simplefilter/version'
require 'simplefilter/connection'
require 'simplefilter/fetch'

module Histock
    class Simplefilter
        include Connection
        include Fetch

        BASE_URL = 'https://histock.tw/stock'

        def initialize
        end
    end
end
