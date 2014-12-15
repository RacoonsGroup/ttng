module ApplicationHelper
  def icon(name)
    content_tag(:span, '', class: "glyphicon glyphicon-#{name}")
  end

  def button(icon:, text:, url:, method: :get, type:'primary', params:{})
    params.tap do |p|
      p[:'data-method'] = method if method != :get
      p[:class] = "btn btn-#{type}"
      p[:href] = url
    end
    content_tag(:a, params) do
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

  def actions_for(entity)
    content_tag(:div, class: 'btn-group') do
      StringIO.open do |s|

        if can? :edit, entity
          s << button(icon: :edit, text: t('actions.edit'), url: edit_polymorphic_path(entity), type: 'success')
        end

        if can? :destroy, entity
          s << button(icon: :remove, text: t('actions.destroy'), url: polymorphic_path(entity), method: :delete, type: 'danger')
        end
        s.string.html_safe
      end
    end
  end

  def iteration_date(date)
    date.strftime('%d.%m')
  end
end
