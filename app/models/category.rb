class Category < ActiveRecord::Base
  has_many :categorizations
  has_many :assets, :through => :categorizations
  has_many :translations, :through => :assets
end