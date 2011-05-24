require 'spec_helper'

describe Parser do

  def parse_row
    @parser.parse(@filename).first
  end

  before(:each) do
    @filename = "spec/dummy.csv"
    @parser = Parser.new
  end

  it "parses the passed file" do
    @parser.parse(@filename).count.should == 2
  end

  it "parses only requested attributes" do
    @parser.parse_attribute(:string)
    record = parse_row
    record.should include(:string)
    record.should_not include(:integer)
    record[:string].should == "chunky"
  end

  it "maps parsed attributes to different column names" do
    @parser.parse_attribute(:name, :from_column => :string)
    record = parse_row
    record.should_not include(:string)
    record[:name].should == "chunky"
  end

  it "convert fields using lambdas" do
    @parser.parse_attribute(:string, :type => lambda { |f| "CHUNKY BACON" })
    record = parse_row
    record[:string].should == "CHUNKY BACON"
  end

  it "convert fields to integers" do
    @parser.parse_attribute(:integer, :type => :integer)
    record = parse_row
    record[:integer].should == 1
  end

  it "yields processed attributes for each call to a given block" do
    @parser.parse_attribute(:string)
    should_receive(:yielded).with(hash_including(:string), 1)
    should_receive(:yielded).with(hash_including(:string), 2)

    @parser.parse(@filename) do |record, lineno|
      yielded(record, lineno)
    end
  end

  it "accepts custom converters for more clean specifications" do
    @parser.parse_attribute(:string, :type => :chunky)
    @parser.add_converter :chunky do |value|
      "CHUNKY BACON"
    end
    record = parse_row
    record[:string].should == "CHUNKY BACON"
  end

end
