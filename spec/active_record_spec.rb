require 'spec_helper'

describe ActiveRecord::Base do

  it "should include Importable::ActiveRecord::Extensions" do
    included_modules = ActiveRecord::Base.included_modules
    included_modules.should include(Importable::ActiveRecord::Extensions)
  end

  it "importable_from_csv includes Importable::ActiveRecord::Import" do
    model_class = Class.new(ActiveRecord::Base)
    included_modules = model_class.included_modules
    included_modules.should_not include(Importable::ActiveRecord::Import)

    model_class.importable_from_csv
    included_modules = model_class.included_modules
    included_modules.should include(Importable::ActiveRecord::Import)
  end

end
