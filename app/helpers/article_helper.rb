module ArticleHelper
  def importance_label(article)
    content_tag :span, article.importance, class: "badge importance-#{article.importance} importance"
  end

  def read_button(article)
    return if article.user == current_user
    if article.users.include?(current_user)
      link_to(unread_article_path(article), method: :POST, class: 'btn btn-warning', title: t('article.buttons.unread'), :'data-toggle' => 'tooltip', :'data-placement' => 'bottom', tooltip: true) do
        glyph(:remove)
      end
    else
      link_to(read_article_path(article), method: :POST, class: 'btn btn-success', title: t('article.buttons.read'), :'data-toggle' => 'tooltip', :'data-placement' => 'bottom', tooltip: true) do
        glyph(:ok)
      end
    end
  end
end