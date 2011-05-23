require 'spec_helper'

describe Parsable::ActiveRecord::Extensions do

  def record_mock(stubs = {})
    @record_mock = mock(@model).as_null_object
  end

  describe "when importing" do 

    it "creates a new record for each row" do
      @model = Class.new(ActiveRecord::Base)
      @model.should_receive(:parse_csv).and_yield({"these" => "attributes"}, 1)
      @model.should_receive(:create).with({"these" => "attributes"}) { record_mock }
      record_mock.stub(:valid?) { true }
      @model.import("path/to/file.csv")
    end

  end

end

describe ActiveRecord::Base do

  it "should include DSL module" do
    ActiveRecord::Base.included_modules.should include(Parsable::DSL)
  end

  it "should include Parsable::ActiveRecord::Extensions" do
    ActiveRecord::Base.included_modules.should include(Parsable::ActiveRecord::Extensions)
  end

end
