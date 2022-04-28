class CreateCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :courses do |t|
      t.string :title
      t.string :currency
      t.float :price
      t.string :course_type
      t.boolean :is_launched
      t.string :url
      t.text :description
      t.integer :expiration_period
      t.integer :user_id

      t.timestamps
    end
  end
end
