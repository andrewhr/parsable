require 'parsable/dsl'
require 'active_record'

module Parsable
  
  module ActiveRecord

    module Extensions

      def self.included(base)
        base.extend(ClassMethods)
        base.send :include, DSL
      end

      module ClassMethods

        def import(filename, options={})
          records = []
          parse_csv(filename, options) do |attributes|
            record = create(attributes)
            yield record if block_given?
            records << record
          end
          records
        end

      end

    end

  end

end

ActiveRecord::Base.send :include, Parsable::ActiveRecord::Extensions
