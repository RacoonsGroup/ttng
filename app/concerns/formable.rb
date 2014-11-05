module Formable
  extend ActiveSupport::Concern

  class Field
    attr_reader :name, :type

    def initialize(name, type)
      @name = name
      @type = type
    end

    def ==(other)
      self.name == other.name
    end

    def number?
      @type == :integer
    end

    def limit
      nil
    end

    def cast(value)
      send(@type, value)
    end

    protected

    def integer(value)
      Integer(value)
    end

    def datetime(value)
      DateTime.parse(value)
    end

    def string(value)
      String(value)
    end

    def json(value)
      if value.kind_of?(Hash)
        value.recursive_symbolize_keys!
      else
        JSON.load(value).recursive_symbolize_keys!
      end
    end
  end

  included do
    include ActiveModel::Validations
    include ActiveModel::Conversion
    extend ActiveModel::Naming

    class_attribute :fields
    self.fields = []
  end

  module ClassMethods
    def field(name, type = nil)
      new_field = Formable::Field.new(name, type)

      if self.fields.include?(new_field)
        raise FieldExistsError.new(name, self.name)
      else
        self.fields += [new_field]
      end

      attr_reader name

      define_field_method(name, type)
    end

    def field_by_name(name)
      self.fields.detect{|field| field.name == name}
    end

    def define_field_method(name, type)
      define_method "#{name}=" do |value|
        value = self.class.field_by_name(name).cast(value) if value.present? && type.present?
        instance_variable_set("@#{name}", value)
      end
    end
  end

  def column_for_attribute(name)
    self.class.field_by_name(name)
  end

  def each_field
    self.class.fields.each do |field|
      yield field, send(field.name)
    end
  end

  def to_hash
    self.class.fields.inject({}) do |hash, field|
      value = send(field.name)
      hash[field.name] = value unless value.nil?
      hash
    end
  end

  def persisted?
    false
  end

  def attributes
    to_hash.with_indifferent_access
  end
end