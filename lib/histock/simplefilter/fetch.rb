require 'nokogiri'
require File.expand_path(File.dirname(__FILE__)) + '/error'
require File.expand_path(File.dirname(__FILE__)) + '/fetch/basic_financial_statements'
require File.expand_path(File.dirname(__FILE__)) + '/fetch/dividend_policy'
require File.expand_path(File.dirname(__FILE__)) + '/fetch/profitability'
require File.expand_path(File.dirname(__FILE__)) + '/fetch/corporate_value'

module Histock
    module Fetch
        include BasicFinancialStatements
        include DividendPolicy
        include Profitability
        include CorporateValue

        private

        def parse query:, html:
            doc = Nokogiri::HTML.parse(html, nil, @charset)
            # => Nokogiri::HTML::Document

            case query
            when :monthly_revenue, :dividend_policy
                nodes = doc.xpath("//div[@class='row-stock']/div[@class='tb-outline']/table[@class='tb-stock text-center tbBasic']")
                # => Nokogiri::XML::NodeSet
            when :income_statement
                nodes = doc.xpath("//div[@class='row-stock']/div[@class='tb-outline']/div/table[@class='tb-stock tbBasic']")
            when :profit_ratio, :income_rate
                nodes = doc.xpath("//div[@class='row-stock w1060']/div[@class='tb-outline']/div/table[@class='tb-stock tbBasic']")
            when :price_to_earning_ratio
                nodes = doc.xpath("//div[@class='row-stock w740']/table[@class='tb-stock tb-outline tbBasic']")
            when :price_book_ratio
                nodes = doc.xpath("//div[@class='row-stock']/table[@class='tb-stock tb-outline tbBasic']")
            end

            raise InformationNotFound if nodes.empty?
            raise XMLNodeSetError unless nodes.length.is_one?

            node = nodes.first
            # => Nokogiri::XML::Element

            parse_table(:query => query, :element => node)
        end

        def parse_table query:, element:
            if children_is_tbody(:element => element)
                table = parse_tr(:query => query, :element => fetch_tbody(:element => element))
            else
                table = parse_tr(:query => query, :element => element)
            end

            case query
            when :price_to_earning_ratio, :price_book_ratio
                _table = Array.new

                _table.concat([table[0][0..1]])

                # remove header
                table.slice!(0)

                until table.flatten.empty? do
                    _table.concat(table.map { |e| e.slice!(0, 2) })
                end

                table = _table
            end

            table
        end

        def children_is_tbody element:
            nodes = element.children

            nodes.length.is_one? and nodes.first.name == 'tbody'
        end

        def fetch_tbody element:
            element.children
        end

        # column
        def parse_tr query:, element:
            array = Array.new

            element.children.each do |e|
                next unless e.element?

                case e.name
                when 'tr'
                    value = parse_th_td(:query => query, :element => e)

                    array.push value unless value.empty?
                else
                    raise TableFormatError
                end
            end

            case query
            when :monthly_revenue
                header = array.delete_at(0)
                header.delete_at(-1)
                header.delete_at(-1)

                header.push array.delete_at(0)
                header.flatten!

                array.unshift(header)
            end

            array
        end

        # row
        def parse_th_td query:, element:
            array = Array.new

            element.children.each do |e|
                next unless e.element?

                case e.name
                when 'th' then array.push e.children.text.gsub(/\<br\>/, '')
                when 'td' then array.push e.children.text
                else raise TableFormatError
                end
            end

            array
        end
    end
end

class Integer
    def is_one?
        self == 1
    end
end
