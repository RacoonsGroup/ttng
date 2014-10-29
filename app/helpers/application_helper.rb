module ApplicationHelper
  def icon(name)
    content_tag(:span, '', class: "glyphicon glyphicon-#{name}")
  end

  def button(icon:, text:, url:, method: :get, type:'primary')
    content_tag(:a, href: url, class: "btn btn-#{type}", :'data-method' => method) do
          content_tag(:div, class: 'visible content') do
            icon(icon)
          end
    end
  end

  def ll(date)
    if date.present?
      l(date)
    else
      ''
    end
  end


end
