# frozen_string_literal: true

module Gratifications
  class BaseGratification
    include ActiveModel::Model

    def calculate
      raise NotImplementedError, 'Debe implementar #calcular'
    end

    def initialize(gratification) end

    def fields
      param_fields.zip(label_fields)
    end

    def self.param_fields(*fields)
      define_method(:param_fields) { fields }
    end

    def self.label_fields(*labels)
      define_method(:label_fields) { labels }
    end
  end
end
