# frozen_string_literal: true

# ペット
class CreatePets < ActiveRecord::Migration[6.1]
  def change
    create_table :pets do |t|
      t.string :name, null: false, index: { unique: true }
      t.string :tag, index: true

      t.timestamps
    end
  end
end
