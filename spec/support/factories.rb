module CartoSet
  module Factories
    def drop_tables
      CartoDB::Connection.tables.each do |table|
        CartoDB::Connection.drop_table table.id
      end
    end
  end
end
RSpec.configuration.include CartoSet::Factories