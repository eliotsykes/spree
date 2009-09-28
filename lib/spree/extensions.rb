module Spree
  class Extensions
    # Define SPREE_EXTENSIONS_LOAD_ORDER in config/preinitializer.rb if you want to
    # specify a custom extension load order.  You may have to create preinitializer.rb
    # yourself, this is an optional Spree file.
    # E.g. add the following line to preinitializer.rb to load the localization
    # extension first, and the site extension last:
    # SPREE_EXTENSIONS_LOAD_ORDER = [:localization, :all, :site]
    def self.load_order
      if defined?(SPREE_EXTENSIONS_LOAD_ORDER)
        return SPREE_EXTENSIONS_LOAD_ORDER
      end
      default_load_order
    end
    
    def self.default_load_order
      [:all]
    end
  end
end
