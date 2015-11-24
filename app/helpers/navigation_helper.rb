module NavigationHelper
  def main_navigation
    render_navigation renderer: :bootstrap do |primary|
      primary.dom_class = 'nav navbar-nav'
      primary.selected_class = 'active'

      primary.item :key_1_1, t('navigation.home'), root_path, class: 'item', icon: 'home'
      primary.item :key_1_2, t('navigation.wiki'), wiki_path, class: 'item', highlights_on: :subpath if can? :read, WikiPage
      primary.item :key_1_3, t('navigation.tasks'), related_tasks_path, class: 'item', highlights_on: :subpath if can? :read, RelatedTask
      primary.item :key_1_4, t('navigation.articles'), articles_path, class: 'item', highlights_on: :subpath if can? :read, Article
      primary.item :key_1_5, t('navigation.my_projects'), projects_path, class: 'item', highlights_on: :subpath if can? :read, Project
      primary.item :key_1_6, t('navigation.users'), users_path, class: 'item', highlights_on: :subpath if can? :read, User
      primary.item :key_1_7, t('navigation.customers'), customers_path, class: 'item', highlights_on: :subpath if can? :read, Customer
      primary.item :key_1_8, t('navigation.contacts'), contacts_path, class: 'item', highlights_on: :subpath if can? :read, Contact
    end
  end

  def admin_navigation
    render_navigation renderer: :bootstrap do |primary|
      primary.dom_class = 'nav navbar-nav'
      primary.selected_class = 'active'
      primary.item :key_1_1, t('navigation.home'), root_path, class: 'item', icon: 'home'
      primary.item :key_1_2, t('navigation.users'), admin_users_path, class: 'item', icon: 'user', highlights_on: :subpath if can? :read, User
      primary.item :key_1_3, t('navigation.projects'), admin_projects_path, class: 'item', icon: 'user', highlights_on: :subpath if can? :read, Project
      primary.item :key_1_4, t('navigation.tasks'), admin_related_tasks_path, class: 'item', highlights_on: :subpath if can? :read, RelatedTask
      primary.item :key_1_5, t('navigation.customers'), admin_customers_path, class: 'item', icon: 'user', highlights_on: :subpath  if can? :read, Customer
      primary.item :key_1_6, t('navigation.contacts'), admin_contacts_path, class: 'item', highlights_on: :subpath if can? :read, Contact
      primary.item :key_1_7, t('navigation.articles'), admin_articles_path, class: 'item', highlights_on: :subpath if can? :read, Article
      primary.item :key_1_8, t('navigation.days'), admin_days_path, class: 'item', icon: 'user', highlights_on: :subpath if can? :read, Project
    end
  end
end
