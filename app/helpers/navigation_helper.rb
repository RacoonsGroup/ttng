module NavigationHelper
  def main_navigation
    render_navigation renderer: :bootstrap do |primary|
      primary.dom_class = 'nav navbar-nav'
      primary.selected_class = 'active'

      primary.item :key_1_1, t('navigation.home'), root_path, class: 'item', icon: 'home'
      primary.item :key_1_2, t('navigation.tasks'), tasks_path, class: 'item'
    end
  end

  def admin_navigation
    render_navigation renderer: :bootstrap do |primary|
      primary.dom_class = 'nav navbar-nav'
      primary.selected_class = 'active'
      primary.item :key_1_1, t('navigation.home'), root_path, class: 'item', icon: 'home'
      primary.item :key_1_2, t('navigation.users'), admin_users_path, class: 'item', icon: 'user', highlights_on: :subpath if can? :read, User
      primary.item :key_1_3, t('navigation.customers'), admin_customers_path, class: 'item', icon: 'user', highlights_on: :subpath  if can? :read, Customer
      primary.item :key_1_4, t('navigation.projects'), admin_projects_path, class: 'item', icon: 'user', highlights_on: :subpath if can? :read, Project
    end
  end
end