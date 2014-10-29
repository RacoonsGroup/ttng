module Admin::AdminHelper
  def admin_actions_for(entity)
    content_tag(:div, class: 'btn-group') do
      StringIO.open do |s|

        if can? :edit, entity
          s << button(icon: :edit, text: t('actions.edit'), url: edit_polymorphic_path([:admin, entity]), type: 'success')
        end

        if can? :destroy, entity
          s << button(icon: :remove, text: t('actions.destroy'), url: polymorphic_path([:admin, entity]), method: :delete, type: 'danger')
        end
        s.string.html_safe
      end
    end
  end
end