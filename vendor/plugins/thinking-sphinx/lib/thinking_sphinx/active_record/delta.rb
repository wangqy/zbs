module ThinkingSphinx
  module ActiveRecord
    # This module contains all the delta-related code for models. There isn't
    # really anything you need to call manually in here - except perhaps
    # index_delta, but not sure what reason why.
    # 
    module Delta
      # Code for after_commit callback is written by Eli Miller:
      # http://elimiller.blogspot.com/2007/06/proper-cache-expiry-with-aftercommit.html
      # with slight modification from Joost Hietbrink.
      #
      def self.included(base)
        base.class_eval do
          #use after_commit plugin

          private
          
          # Set the delta value for the model to be true.
          def toggle_delta
            self.delta = true
          end
          
          # Build the delta index for the related model. This won't be called
          # if running in the test environment.
          # 
          def index_delta
            if ThinkingSphinx::Configuration.environment == "test" ||
              !ThinkingSphinx.deltas_enabled?
              return true
            end
            
            configuration = ThinkingSphinx::Configuration.new
            system "indexer --config #{configuration.config_file} --rotate #{self.class.name.downcase}_delta"
            
            true
          end
        end
      end
    end
  end
end
