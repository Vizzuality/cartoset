module CartoSet
  module Factories
    def drop_tables
      CARTODB.tables.each do |table|
        CARTODB.drop_table table.id
      end
    end
  end
end
RSpec.configuration.include CartoSet::Factories