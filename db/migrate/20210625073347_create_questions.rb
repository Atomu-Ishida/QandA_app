class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.references :user, foreign_key: true
      t.string :title, limit: 30, null: false
      t.text :description,null: false
      t.boolean :solved, default: false, null: false
      
      t.timestamps
    end
  end
end
