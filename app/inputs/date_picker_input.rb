class DatePickerInput < SimpleForm::Inputs::Base
  def input
    input_html_options[:class].push :'form-control'
    input_html_options[:value] = I18n::l(object.attributes[attribute_name.to_s]) rescue ''
    @builder.text_field(attribute_name, input_html_options)
  end
end