module CartoSet
  module Factories
    module Features

      def create_table(attributes = {})
        @features_table = CARTODB.create_table 'features'
      end

      def new_feature(values = {})
        create_table unless @features_table.present?

        default_values = {
          'name'        => 'feature',
          'description' => 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
          'latitude'    => -16.5060,
          'longitude'   => -151.7531
        }
        values = default_values.merge(values)

        CARTODB.insert_row @features_table.id, values
      end

      def create_random_features(ammount = 25)
        ammount.times do |i|
          new_feature({:name => "Feature #{i}"})
        end
      end
    end

  end
end
RSpec.configuration.include CartoSet::Factories::Features