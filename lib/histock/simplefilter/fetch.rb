require 'nokogiri'
require 'fetch/dividend_policy'

module Histock
    module Fetch
        include DividendPolicy

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

            array = []

            node.children.each do |e|
                next unless e.element?

                case e.name
                when 'tr'
                    value = parse_th(query: query, element: e)

                    array.push value unless value.empty?
                else
                    raise TableFormatError
                end
            end

            array
        end

        def parse_th query:, element:
            value = Array.new

            element.children.each do |e|
                case e.name
                when 'th' then value.push e.children.to_s.gsub(/\<br\>/, '')
                when 'td' then value.push e.children.to_s
                else puts e.name; raise TableFormatError
                end
            end

            value
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
