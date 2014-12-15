module Admin::AdminHelper
  def admin_actions_for(entity_or_array, size: 'md', edit_params: {})
    array = [entity_or_array].flatten
    entity = array.last
    content_tag(:div, class: "btn-group btn-group-#{size}") do
      StringIO.open do |s|

        if can? :edit, entity
          s << button(icon: :edit, text: t('actions.edit'), url: edit_polymorphic_path([:admin, array].flatten), type: 'success', params: edit_params)
        end

        if can? :destroy, entity
          s << button(icon: :remove, text: t('actions.destroy'), url: polymorphic_path([:admin, array].flatten), method: :delete, type: 'danger')
        end
        s.string.html_safe
      end
    end
  end
end