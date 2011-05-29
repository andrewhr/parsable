require 'active_support'

module Parsable

  module DSL
    extend ActiveSupport::Concern

    module ClassMethods

      def parse_csv(filename, options = {}, &block)
        parser.parse(filename, options, &block)
      end

      def column(name, options = {})
        attribute_name = options.delete(:as) || name
        options        = options.merge(:from_column => name)
        parser.parse_attribute(attribute_name, options)
      end

      private

      def parser
        @parser ||= Parser.new
      end

    end

  end

end
