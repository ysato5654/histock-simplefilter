require 'open-uri'

module Histock
    module Connection
        def get(path, **params)
            request(path, params)
        end

        private

        def request(path, params)
            connection(path, params)
        end

        def connection(path, params)
            @url = Simplefilter::BASE_URL + path + '?' + params.map { |key, val| [key, val].join('=') }.join('&')

            @charset = nil
            html = open(@url) do |f|
                @charset = f.charset
                f.read
            end

            @charset = html.scan(/charset="?([^\s"]*)/i).first.join if @charset.nil?

            html
        end
    end
end
