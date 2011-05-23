require 'spec_helper'

describe Parsable::ActiveRecord::Extensions do


  describe "when importing" do 

    it "creates a new record for each row" do
      active_record = Class.new(ActiveRecord::Base)
      active_record.should_receive(:parse_csv).and_yield({"these" => "attributes"})
      active_record.should_receive(:create).with({"these" => "attributes"})
      active_record.import("path/to/file.csv")
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
