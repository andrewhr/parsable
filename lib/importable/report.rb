module Importable

  class Report

    def initialize(filename)
      @report = "Importing data from file \"#{filename}\". Please wait...\n"
    end

    def report_errors(errors, lineno)
      @report << "\tThe record on line ##{lineno} can't be saved:\n"
      errors.each_full do |msg|
        @report << "\t\t* #{msg}\n"
      end
    end

    def to_s
      @report
    end

  end

end
