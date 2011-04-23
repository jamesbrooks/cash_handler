require 'timeout'
require 'yaml'

module CashHandler

  # Parses exchange rates sourced from themoneyconverter.com/USD/rss.xml
  class Parser

    attr_accessor :backup_rates_file_location

    def initialize(backup_rates_file_location = nil)
      @backup_rates_file_location = backup_rates_file_location
    end

    # Fetches a hash of up-to-date rates from themoneyconverter.com/USD/rss.xml
    def fetch_rates
      rates = {}
      begin
        Timeout.timeout(60) do
          doc = Hpricot.XML(open('http://themoneyconverter.com/USD/rss.xml'))
          (doc/:item).each do |item|
            country = (item/:title).inner_html.split('/')[0]
            conversion_match = (item/:description).inner_html[/=.?(\d+\.?\d*)/]
            # 1 USD country rate 'in USD'
            rates[country] = 1.0 / $1.to_f
          end
          rates.update({'USD' => 1.0})
          persist_rates(rates)
        end
      rescue Exception
        rates = fetch_persisted_rates
      end
      rates
    end
    
    private
    
    def persist_rates(rates)
      if @backup_rates_file_location && backup_file = File.new(@backup_rates_file_location, "w+")
        backup_file << rates.to_yaml
        backup_file.close
      end
    end
    
    def fetch_persisted_rates
      rates = {}
      if @backup_rates_file_location && backup_file = File.new(@backup_rates_file_location, "r")
        rates = YAML.load(backup_file)
        backup_file.close
      end
      rates
    end

  end
end
