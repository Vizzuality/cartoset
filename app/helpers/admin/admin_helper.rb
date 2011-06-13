module Admin::AdminHelper
  def build_field_for_column(column, value = nil)
    case column[:type]
    when 'boolean'
      ul_content = ''
      selected = "selected"
      value = (value.blank?)? 'null' : value.to_s
      puts value
      ul_content << '<li><a class="radiobutton '+((value=="true")? selected:'')+'" href="#true">true</a></li>'
      ul_content << '<li><a class="radiobutton '+((value=="false")? selected:'')+'" href="#false">false</a></li>'
      ul_content << '<li><a class="radiobutton '+((value=="null")? selected:'')+'" href="#null">null</a></li>'
      ul_content << radio_button_tag(column[:name], true, (value=="true"), :class=>"hidden")
      ul_content << radio_button_tag(column[:name], false, (value=="false"), :class=>"hidden")
      ul_content << radio_button_tag(column[:name], "null", (value=="null"), :class=>"hidden")
      content_tag :ul, raw(ul_content)
    when 'number'
      number_field_tag column[:name], value, :id => column[:name], :class => column[:type]
    when 'date'
      text_field_tag(column[:name], value, :readonly => "readonly", :id => column[:name], :class => column[:type]) + content_tag(:div, date_select(column[:name], :name), :class => 'date show')
    else
      text_field_tag column[:name], value, :id => column[:name], :class => column[:type]
    end    
  end
end