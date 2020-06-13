module Histock
    module Fetch
        module CorporateValue
            def price_to_earning_ratio(code)
                params = {:no => code, :t => 6, :st => 1}
                parse(:query => __method__, :html => get('/financial.aspx', params))
            end

            def price_book_ratio(code)
                params = {:no => code, :t => 6, :st => 2}
                parse(:query => __method__, :html => get('/financial.aspx', params))
            end
        end
    end
end
