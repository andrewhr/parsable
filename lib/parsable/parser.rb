# encoding: UTF-8
require 'csv'

module Parsable

  class Parser

    AttributeInfo = Struct.new :column_header, :converter

    def parse(filename, options = {})
      options = options.merge(:headers => true)

      records = []
      CSV.foreach(filename, options) do |row|
        record = parse_row(row)
        yield record if block_given?
        records << record
      end
      records
    end

    def parse_attribute(name, options = Hash.new)
      attributes[name] = AttributeInfo.new
      attributes[name].column_header = options[:from_column] || name
      attributes[name].converter = options[:type]
    end

    def add_converter(name, &block)
      converters[name] = block
    end

    private

    def attributes
      @attributes ||= {}
    end

    def parse_row(row)
      record = {}
      attributes.each do |attr, info|
        value = row[info.column_header.to_s]
        value = convert(value, info.converter) unless info.converter.nil?
        record[attr] = value
      end
      record
    end

    def converters
      @converters ||= { :integer => lambda { |v| v.to_i } }
    end

    def convert(value, converter)
      converter = converters[converter] if converter.kind_of? Symbol
      converter.call(value)
    end

  end

end
