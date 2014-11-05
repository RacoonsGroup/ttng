module TaskHelper
  def task_glyph(task)
    content_tag(:span, :'data-toggle' => 'tooltip', title: task.task_type_i18n, :'data-placement' => 'bottom', tooltip: true ) do
      send("#{task.task_type}_glyph")
    end
  end

  def feature_glyph
    glyph(:star)
  end

  def bug_glyph
    glyph(:'warning-sign')
  end

  def chore_glyph
    glyph(:'wrench')
  end

  def payable_options
    %w[all true false].each{ |s| [s, s]}
  end
end