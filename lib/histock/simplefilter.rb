require File.expand_path(File.dirname(__FILE__)) + '/simplefilter/version'
require File.expand_path(File.dirname(__FILE__)) + '/simplefilter/connection'
require File.expand_path(File.dirname(__FILE__)) + '/simplefilter/fetch'

module Histock
    class Simplefilter
        include Connection
        include Fetch

        BASE_URL = 'https://histock.tw/stock'

        def initialize
        end
    end
end
