require 'spec_helper'

describe Parsable::DSL do

  def mock_parser(stubs = {})
    @mock_parser ||= mock(Parser, stubs).as_null_object
  end

  before(:each) do
    @klass = Class.new { include Parsable::DSL }
    @klass.stub(:parser) { mock_parser }
  end

  describe ".column" do

    it "delegates to Parsable::Parser#parse_attribute" do
      mock_parser.should_receive(:parse_attribute).
                  with(:header, hash_including(:from_column => :header))
      @klass.column :header
    end

    it "interprets :as option as column header alias" do
      mock_parser.should_receive(:parse_attribute).
                  with(:attribute_name, hash_including(:from_column => :header))
      @klass.column :header, :as => :attribute_name
    end

    it "interprets :type option as type column" do
      mock_parser.should_receive(:parse_attribute).
                  with(anything, hash_including(:type => :string))
      @klass.column :header, :type => :string
    end

  end

  describe ".parse_csv" do

    it "delegates to Parsable::Parser#parse" do
      mock_parser.should_receive(:parse).with("path/to/file.csv", anything)
      @klass.parse_csv "path/to/file.csv"
    end

    it "delegates to Parsable::Parser#parse with options if provided" do
      mock_parser.should_receive(:parse).with(anything,
                                               hash_including(:col_sep => "<3"))
      @klass.parse_csv "path/to/file.csv", :col_sep => "<3"
    end

    it "delegates to Parsable::Parser#parse and yields a attribute hash" do
      mock_parser.should_receive(:parse).and_yield({"some" => "attributes"})
      should_receive(:yielded).with({"some" => "attributes"})
      @klass.parse_csv "path/to/file.csv" do |attributes|
        yielded(attributes)
      end
    end

  end

end
