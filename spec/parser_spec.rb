require 'spec_helper'

describe Parser do

  before(:each) do
    @parser = Parser.new("spec/dummy.csv")
  end

  it "parses the passed file" do
    @parser.parse.count.should == 2
  end

  it "parses only requested attributes" do
    @parser.parse_attribute(:string)
    record = @parser.parse.first
    record.should include(:string)
    record.should_not include(:integer)
    record[:string].should == "chunky"
  end

  it "maps parsed attributes to different column names" do
    @parser.parse_attribute(:name, :from_column => :string)
    record = @parser.parse.first
    record.should_not include(:string)
    record[:name].should == "chunky"
  end

  it "convert fields using lambdas" do
    @parser.parse_attribute(:string, :type => lambda { |f| "CHUNKY BACON" })
    record = @parser.parse.first
    record[:string].should == "CHUNKY BACON"
  end

  it "convert fields to integers" do
    @parser.parse_attribute(:integer, :type => :integer)
    record = @parser.parse.first
    record[:integer].should == 1
  end

  it "yields processed attributes for each call to a given block" do
    @parser.parse_attribute(:string)
    should_receive(:yielded).twice.with(hash_including(:string))
    @parser.parse do |record|
      yielded(record)
    end
  end

  it "accepts custom converters for more clean specifications" do
    @parser.parse_attribute(:string, :type => :chunky)
    @parser.add_converter :chunky do |value|
      "CHUNKY BACON"
    end
    record = @parser.parse.first
    record[:string].should == "CHUNKY BACON"
  end

end
