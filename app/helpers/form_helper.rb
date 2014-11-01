module FormHelper
  def form_group(label:, required:false, &block)
    content_tag(:div, class: 'form-group') do
      content_tag(:label, label_with_mark(label, required)) +
          capture(&block)
    end
  end

  def label_with_mark(label, required)
    if required
      "* #{label}"
    else
      label
    end
  end
end