module NavigationHelper
  def main_navigation
    render_navigation renderer: :bootstrap do |primary|
      primary.dom_class = 'nav navbar-nav'
      primary.selected_class = 'active'

      primary.item :key_1_1, t('navigation.home'), main_app.root_path, class: 'item', icon: 'home'
      primary.item :key_1_2, t('navigation.wiki'), main_app.wiki_path, class: 'item', highlights_on: :subpath if can? :read, WikiPage
      primary.item :key_1_3, t('navigation.tasks'), main_app.related_tasks_path, class: 'item', highlights_on: :subpath if can? :read, RelatedTask
      primary.item :key_1_4, t('navigation.articles'), main_app.articles_path, class: 'item', highlights_on: :subpath if can? :read, Article
      primary.item :key_1_5, t('navigation.my_projects'), main_app.projects_path, class: 'item', highlights_on: :subpath if can? :read, Project
      primary.item :key_1_6, t('navigation.users'), main_app.users_path, class: 'item', highlights_on: :subpath if can? :read, User
      primary.item :key_1_7, t('navigation.customers'), main_app.customers_path, class: 'item', highlights_on: :subpath if can? :read, Customer
      primary.item :key_1_8, t('navigation.contacts'), main_app.contacts_path, class: 'item', highlights_on: :subpath if can? :read, Contact
    end
  end

  def admin_navigation
    render_navigation renderer: :bootstrap do |primary|
      primary.dom_class = 'nav navbar-nav'
      primary.selected_class = 'active'
      primary.item :key_1_1, t('navigation.home'), main_app.root_path, class: 'item', icon: 'home'
      primary.item :key_1_2, t('navigation.users'), main_app.admin_users_path, class: 'item', icon: 'user', highlights_on: :subpath if can? :read, User
      primary.item :key_1_3, t('navigation.projects'), main_app.admin_projects_path, class: 'item', icon: 'user', highlights_on: :subpath if can? :read, Project
      primary.item :key_1_4, t('navigation.tasks'), main_app.admin_related_tasks_path, class: 'item', highlights_on: :subpath if can? :read, RelatedTask
      primary.item :key_1_5, t('navigation.customers'), main_app.admin_customers_path, class: 'item', icon: 'user', highlights_on: :subpath  if can? :read, Customer
      primary.item :key_1_6, t('navigation.contacts'), main_app.admin_contacts_path, class: 'item', highlights_on: :subpath if can? :read, Contact
      primary.item :key_1_7, t('navigation.articles'), main_app.admin_articles_path, class: 'item', highlights_on: :subpath if can? :read, Article
      primary.item :key_1_8, t('navigation.days'), main_app.admin_days_path, class: 'item', icon: 'user', highlights_on: :subpath if can? :read, Project
    end
  end
end
