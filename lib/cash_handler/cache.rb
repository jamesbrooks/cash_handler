module CashHandler
  
  # Stores a cache of conversion values as rates against the USD
  class Cache
    attr_accessor :ttl
    
    # Creates the cache with a default TTL (time to live) of 1 day. After this TTL has elapsed, cached values are refreshed
    def initialize(ttl=1.day)
      @ttl = ttl
      @expires_at = ttl.from_now
      
      expire_cache
    end
    
    # Forces an expiry of the cache
    def expire_cache
      @expires_at = ttl.from_now
      @rates = CashHandler::Parser.fetch_rates
    end
    
    # Fetches a cached values (and refreshes the cache if it has expired)
    def get(code)
      # Ensure we have a collection of rates
      expire_cache unless @rates && @rates.any? && @expires_at > Time.now
      
      if @rates[code]
        @rates[code]
      else
        # Can't find a rate by that code
        raise CashHandler::Exception.new("'#{code}' is not a supported currency code")
      end
    end
  end
end
