class DatePickerInput < SimpleForm::Inputs::Base
  def input
    input_html_options[:class].push :'form-control'
    input_html_options[:value] = value
    @builder.text_field(attribute_name, input_html_options)
  end

  private

  def value
    v = object.attributes[attribute_name.to_s] || '' rescue ''
    if v.is_a? String
      v
    else
      I18n::l(v)
    end
  end
end