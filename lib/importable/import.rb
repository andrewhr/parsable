require 'importable/dsl'
require 'importable/report'
require 'active_support'

module Importable

  module ActiveRecord

    module Import
      extend ActiveSupport::Concern
      include Importable::DSL

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
