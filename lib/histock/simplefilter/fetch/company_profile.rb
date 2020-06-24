module Histock
    module Fetch
        module CompanyProfile
            def company_profile(code)
                params = {:no => code}
                parse(:query => __method__, :html => get('/profile.aspx', params))
            end
        end
    end
end
