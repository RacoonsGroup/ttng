module ApplicationHelper
  def icon(name)
    content_tag(:span, '', class: "glyphicon glyphicon-#{name}")
  end

  def button(icon:, text:, url:, method: :get, params:{})
    params.tap do |p|
      p[:'data-method'] = method if method != :get
      p[:class] = "btn btn-default"
      p[:href] = url
    end
    content_tag(:a, params) do
      icon(icon)
    end
  end

  def ll(date)
    if date.present?
      l(date)
    else
      ''
    end
  end

  def actions_for(entity_or_array, size: 'sm', edit_params: {})
    array = [entity_or_array].flatten
    entity = array.last
    content_tag(:div, class: "btn-group btn-group-#{size}") do
      StringIO.open do |s|

        if can? :edit, entity
          s << button(icon: :pencil, text: t('actions.edit'), url: edit_polymorphic_path(array.flatten), params: edit_params)
        end

        if can? :destroy, entity
          s << button(icon: :remove, text: t('actions.destroy'), url: polymorphic_path(array.flatten), method: :delete)
        end
        s.string.html_safe
      end
    end
  end

  def iteration_date(date)
    date.strftime('%d.%m')
  end

  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, {:sort => column, :direction => direction}, {:class => css_class}
  end

  def inline_object(tag, object, attribute, options = {})
    if current_user.chief?
      opts = {
        "contenteditable" => "true",
        "object"          => "true",
        "data-attribute"  => attribute,
        "data-id"         => object.id,
        "data-class"      => object.class.to_s,
        "data-url"        => update_inline_object_path,
        "class"           => options[:class]
      }
      if options[:position]
        opts['data-placement'] = options[:position]
      end
      content_tag(tag, opts) do
        raw(object.send(attribute))
      end
    else
      content_tag(tag, class: "#{options[:class]}") do
        raw(object.send(attribute))
      end
    end
  end
end
