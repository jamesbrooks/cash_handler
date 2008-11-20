module CashHandler
  class Base
    attr_accessor :cache
    
    def initialize
      @cache = CashHandler::Cache.new
    end
    
    # Fetches the exchange rate of a currency against the USD
    def get(code)
      @cache.get(code)
    end
    
    # Converts a value from one currency to another
    def convert(value, from, to)
      value * get(from) / get(to)
    end
  end
end
