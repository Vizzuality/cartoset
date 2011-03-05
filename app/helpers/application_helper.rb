module ApplicationHelper
  def paginate(rows, current_page, total_count, per_page = 10)

    total_pages = (total_count.to_f / per_page.to_f).ceil
    pages = (1..total_pages).to_a

    content_tag :div, :class => 'pagination' do
      raw pages.map{|page| link_to page, '#', :class => page == current_page ? 'current' : nil}.join(' ')
    end
  end
end
