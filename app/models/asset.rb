class Asset < ActiveRecord::Base
  has_many :categorizations
  has_many :categories, :through => :categorizations
  has_many :translations

  module Translatable
    extend ActiveSupport::Concern

    def current_translation_code
      @current_translation_code || self.class.default_translation_code
    end

    def current_translation_code=(code)
      @current_translation = nil
      @current_translation_code = code
    end

    def current_translation=(translation)
      @current_translation = (translation.respond_to?(:code) ? translation : translations.where(:code => translation).first)
    end

    def current_translation
      @current_translation ||= translations.where(:code => current_translation_code).first
    end

    module ClassMethods

      attr_accessor :default_translation_code

      def translate *methods
        options = methods.extract_options!
        self.default_translation_code = options[:default] || "EN"
        methods.each do |meth|
          define_method meth do
            current_translation.send(meth)
          end
        end
      end
    end
  end

  include Translatable

  translate :name, :default => "ES", :class_name => :medical_translations

end