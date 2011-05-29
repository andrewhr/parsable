require 'parsable/dsl'
require 'parsable/report'
require 'active_record'

module Parsable
  
  module ActiveRecord

    module Extensions
      extend ActiveSupport::Concern
      include DSL

      module ClassMethods

        def import(filename, options={})
          records = []
          report  = Report.new(filename)

          parse_csv(filename, options) do |attributes, lineno|
            record = create(attributes)

            if record.valid?
              yield record if block_given?
              records << record
            else
              report.report_errors(record.errors, lineno)
            end

          end

          report
        end

      end

    end

  end

end

ActiveRecord::Base.send :include, Parsable::ActiveRecord::Extensions
