  class UserPositionValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
      record.errors[attribute] << (options[:message] || I18n.t("activerecord.errors.models.#{record.class.to_s.underscore}.attributes.#{attribute}.user_position")) if value.nobody?
    end
  end