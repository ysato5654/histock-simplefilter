require 'nokogiri'
require File.expand_path(File.dirname(__FILE__)) + '/fetch/basic_financial_statements'
require File.expand_path(File.dirname(__FILE__)) + '/fetch/dividend_policy'

module Histock
    module Fetch
        include BasicFinancialStatements
        include DividendPolicy

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
            end

            raise InformationNotFound if nodes.empty?
            raise XMLNodeSetError unless nodes.length.is_one?

            node = nodes.first
            # => Nokogiri::XML::Element

            parse_table(:query => query, :element => node)
        end

        def parse_table query:, element:
            parse_tr(:query => query, :element => element)
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
