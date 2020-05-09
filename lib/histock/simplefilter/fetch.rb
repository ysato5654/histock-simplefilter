require 'nokogiri'
require File.expand_path(File.dirname(__FILE__)) + '/fetch/dividend_policy'
require File.expand_path(File.dirname(__FILE__)) + '/fetch/basic_financial_statements'

module Histock
    module Fetch
        include DividendPolicy
        include BasicFinancialStatements

        private

        def parse query:, html:
            doc = Nokogiri::HTML.parse(html, nil, @charset)
            # => Nokogiri::HTML::Document

            nodes = doc.xpath("//div[@class='row-stock']/div[@class='tb-outline']/table[@class='tb-stock text-center tbBasic']")
            # => Nokogiri::XML::NodeSet

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
            when :financial_statements
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
    def is_zero?
        self == 0
    end

    def is_one?
        self == 1
    end
end

class String
    def is_currency?
        (self =~ /^[+-]?[0-9]*[\,]?[0-9]*[\.]?[0-9]+$/).nil? ? false : true
    end

    def to_currency
        unless self.is_currency?
            STDERR.puts "#{__FILE__}:#{__LINE__}: argument - #{self}"
            raise ArgumentError
        end

        self.gsub(/[\,]/, '').to_f
    end
end
