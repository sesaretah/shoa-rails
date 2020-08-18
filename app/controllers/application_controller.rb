class ApplicationController < ActionController::API
    require 'unicode_fixer'
    before_action :inspect_unicode
    
    def inspect_unicode
        fix_unicode_values(nil, params)
    end
    
    def fix_unicode_values(parent, hash)
        hash.each {|key, value|
          value.is_a?(Hash) ? fix_unicode_values(key, value) : hash[key] = UnicodeFixer.fix(value)
        }
    end

    def owner(obj, user)
        if obj.user_id == user.id
          return true
        else
          return false
        end
    end
end
