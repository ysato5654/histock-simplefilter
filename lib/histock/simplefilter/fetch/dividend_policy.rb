module Histock
    module Fetch
        module DividendPolicy
            def dividend_policy(code)
                params = {:no => code, :t => 2}
                parse(:query => __method__, :html => get('/financial.aspx', params))
            end
        end
    end
end
