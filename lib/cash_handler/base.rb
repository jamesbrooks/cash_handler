module CashHandler
  class Base
    attr_accessor :cache, :backup_rates_file_location
    
    # Init the CashHandler (and cache), with a default TTL of 1 day
    def initialize(ttl=1.day, backup_rates_file_location = nil)
      @cache = CashHandler::Cache.new(ttl, backup_rates_file_location)
    end
    
    # Fetches the exchange rate of a currency against the USD
    def get(code, options={:against => :usd})
      @cache.get(code.to_s.upcase) / @cache.get(options[:against].to_s.upcase)
    end
    
    # Converts a value from one currency to another
    def convert(value, from, to)
      value * get(from, :against => to)
    end
  end
end
