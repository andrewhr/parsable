require 'importable/import'
require 'active_record'

module Importable
  
  module ActiveRecord

    module Extensions
      extend ActiveSupport::Concern

      module ClassMethods

        def importable_from_csv
          include Importable::ActiveRecord::Import
        end

      end

    end

  end

end

ActiveRecord::Base.send :include, Importable::ActiveRecord::Extensions
