class ApplicationController < ActionController::API

    before_action :inspect_unicode
    
    def inspect_unicode
        fix_unicode_values(nil, params)
    end
    
    def fix_unicode_values(parent, hash)
        hash.each {|key, value|
          value.is_a?(Hash) ? fix_unicode_values(key, value) : hash[key] = UnicodeFixer.fix(value)
        }
    end
end
