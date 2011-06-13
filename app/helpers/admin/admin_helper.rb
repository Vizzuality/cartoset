module Admin::AdminHelper
  def build_field_for_column(column, value = nil)
    case column[:type]
    when 'boolean'
      ul_content = ''
      ul_content << content_tag(:li, raw(radio_button_tag(column[:name], true, value)   + label_tag(column[:name] + '_true', 'True', :class => 'radio_label')))
      ul_content << content_tag(:li, raw(radio_button_tag(column[:name], false, !value) + label_tag(column[:name] + '_false', 'False', :class => 'radio_label')))
      content_tag :ul, raw(ul_content)
    when 'number'
      number_field_tag column[:name], value, :id => column[:name], :class => column[:type]
    when 'date'
      text_field_tag(column[:name], value, :id => column[:name], :class => column[:type]) + content_tag(:div, date_select(column[:name], :name), :class => 'date show')
    else
      text_field_tag column[:name], value, :id => column[:name], :class => column[:type]
    end
  end
end