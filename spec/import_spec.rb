require 'spec_helper'

describe Importable::ActiveRecord::Import do
  
  def record_mock(stubs = {})
    @record_mock = mock(@model).as_null_object
  end

  before(:each) do
    @model = Class.new(ActiveRecord::Base) do
      include Importable::ActiveRecord::Import
    end
  end

  it "should include DSL module" do
    included_modules = @model.included_modules
    included_modules.should include(Importable::DSL)
  end

  describe "when importing" do 

    it "creates a new record for each row" do
      @model.should_receive(:parse_csv).and_yield({"these" => "attributes"}, 1)
      @model.should_receive(:create).
             with({"these" => "attributes"}) { record_mock }
      record_mock.stub(:valid?) { true }

      @model.import("path/to/file.csv")
    end

  end

end
