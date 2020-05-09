module Histock
    module Fetch
        module Profitability
            def profit_ratio(code)
                params = {:no => code, :t => 3, :st => 1}
                parse(:query => __method__, :html => get('/financial.aspx', params))
            end

            def income_rate(code, term)
                case term
                when 'month' then params = {:no => code, :t => 3, :st => 2, :q => 1}
                when 'quarter' then params = {:no => code, :t => 3, :st => 2, :q => 2}
                when 'year' then params = {:no => code, :t => 3, :st => 2, :q => 3}
                else
                end

                parse(:query => __method__, :html => get('/financial.aspx', params))
            end
        end
    end
end
