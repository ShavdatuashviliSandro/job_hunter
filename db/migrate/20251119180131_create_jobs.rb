class CreateJobs < ActiveRecord::Migration[7.1]
  def change
    create_table :jobs do |t|
      t.string :title
      t.string :company
      t.text :description
      t.string :link

      t.timestamps
    end
  end
end
