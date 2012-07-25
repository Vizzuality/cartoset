module Admin::AdminHelper
  def paginate(rows, current_page, total_count, per_page = 10, params = {})

    if per_page.is_a?(Hash)
      params = per_page
      per_page = 10
    end

    window      = 2
    total_pages = (total_count.to_f / per_page.to_f).ceil
    last_page   = total_pages - 1

    left  = (current_page - 1).downto(1).to_a.first(window).sort
    right = (current_page + 1).upto(total_pages).to_a.first(window)

    pages = 1.upto(current_page - 1).to_a.map{|p| left.include?(p) || p == 1 ? p : '...'}.uniq + [current_page] + (current_page + 1).upto(last_page).to_a.map{|p| right.include?(p) || p == last_page ? p : '...'}.uniq

    content_tag :div, :class => 'pagination' do
      raw pages.map{|page| page.eql?('...') ? content_tag(:span, page) : link_to(page, admin_path(params.merge({:page => page})), :class => page == current_page ? 'current' : nil)}.join(' ')
    end
  end

  def build_field_for_column(column, value = nil)

    case column[:type]
    when 'boolean'
      ul_content = ''
      selected = "selected"
      value = (value.blank?)? 'null' : value.to_s

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
