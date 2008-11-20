module CashHandler
  
  # Parses exchanges rates sourced from x-rates.com
  class Parser
    class << self
      
      # Fetches a hash of up-to-date rates from x-rates.com
      def fetch_rates
        doc = Hpricot(open('http://www.x-rates.com/d/USD/table.html'))
        
        CashHandler::CURRENCIES.inject({}) do |collection, currency|
          code = currency.first
          collection[code] = (doc/"a[@href=\"/d/USD/#{code}/graph120.html\"]").html.to_f
          collection
        end.update({'USD' => 1.0})
      end
    end
  end
end
