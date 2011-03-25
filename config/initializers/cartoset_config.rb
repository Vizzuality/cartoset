require 'cartoset/config'
include Cartoset

if Cartoset::Config['cartodb_oauth_key'].present? && Cartoset::Config['cartodb_oauth_secret'].present?
  CartoDB::Settings['oauth_key'] = Cartoset::Config['cartodb_oauth_key']
  CartoDB::Settings['oauth_secret'] = Cartoset::Config['cartodb_oauth_secret']
end
