class Form
  include Formable

  def initialize(params = {})
    params ||= {}
    params.each do |key, value|
      send("#{key.to_s.underscore}=", value)
    end
  end

end