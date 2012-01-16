class CreateTranslations < ActiveRecord::Migration
  def change
    create_table :translations do |t|
      t.references :asset
      t.string :code
      t.string :name
    end
  end
end