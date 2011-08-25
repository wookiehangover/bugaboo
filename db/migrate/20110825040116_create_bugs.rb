class CreateBugs < ActiveRecord::Migration
  def change
    create_table :bugs do |t|
      t.integer :project_id
      t.string :summary
      t.text :steps_to_reproduce
      t.integer :author_id
      t.integer :user_assigned_id
      t.string :past_state
      t.string :current_state
      t.string :severity

      t.timestamps
    end
  end
end
