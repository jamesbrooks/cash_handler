require 'open-uri'
require 'hpricot'

module CashHandler
  CURRENCIES = {
    'AUD' => 'Australian Dollar',
    'BRL' => 'Brazilian Real',
    'GBP' => 'British Pound',
    'CAD' => 'Canadian Dollar',
    'CNY' => 'Chinese Yuan',
    'DKK' => 'Danish Krone',
    'EUR' => 'Euro',
    'HKD' => 'Hong Kong Dollar',
    'INR' => 'Indian Rupee',
    'JPY' => 'Japanese Yen',
    'MYR' => 'Malaysian Ringgit',
    'MXN' => 'Mexican Peso',
    'NZD' => 'New Zealand Dollar',
    'NOK' => 'Norwegian Kroner',
    'SGD' => 'Singapore Dollar',
    'ZAR' => 'South African Rand',
    'KRW' => 'South Korean Won',
    'LKR' => 'Sri Lanka Rupee',
    'SEK' => 'Swedish Krona',
    'CHF' => 'Swiss Franc',
    'TWD' => 'Taiwan Dollar',
    'THB' => 'Thai Baht',
    'USD' => 'United States Dollar'
  }  
  
  class << self
    def load
    end
  end
end
