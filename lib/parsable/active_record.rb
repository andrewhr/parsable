require 'parsable/import'
require 'active_record'

module Parsable
  
  module ActiveRecord

    module Extensions
      extend ActiveSupport::Concern

      module ClassMethods

        def importable_from_csv
          include Parsable::ActiveRecord::Import
        end

      end

    end

  end

end

ActiveRecord::Base.send :include, Parsable::ActiveRecord::Extensions
