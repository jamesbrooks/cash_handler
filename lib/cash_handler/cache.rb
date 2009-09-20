module CashHandler
  
  # Stores a cache of conversion values as rates against the USD
  class Cache
    attr_accessor :ttl
    
    # Creates the cache with a default TTL (time to live) of 1 day. After this TTL has elapsed, cached values are refreshed
    def initialize(ttl, backup_rates_file_location)
      @ttl = ttl
      @backup_rates_file_location = backup_rates_file_location
      @expires_at = ttl.from_now
      
      expire
    end
    
    # Forces an expiry of the cache
    def expire
      @expires_at = ttl.from_now
      @rates = CashHandler::Parser.new(@backup_rates_file_location).fetch_rates
    end
    
    # Fetches a cached values (and refreshes the cache if it has expired)
    def get(code)
      # Ensure we have a collection of rates
      expire unless @rates && @rates.any? && @expires_at > Time.now
      
      if @rates[code]
        @rates[code]
      else
        # Can't find a rate by that code
        raise CashHandler::Exception.new("'#{code}' is not a supported currency code")
      end
    end
  end
end
