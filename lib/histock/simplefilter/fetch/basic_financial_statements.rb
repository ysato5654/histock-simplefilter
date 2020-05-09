module Histock
    module Fetch
        module BasicFinancialStatements
            def monthly_revenue(code)
                params = {:no => code, :t => 1, :st => 1}
                parse(:query => __method__, :html => get('/financial.aspx', params))
            end

            def income_statement(code)
                params = {:no => code, :t => 1, :st => 4}
                parse(:query => __method__, :html => get('/financial.aspx', params))
            end
        end
    end
end
