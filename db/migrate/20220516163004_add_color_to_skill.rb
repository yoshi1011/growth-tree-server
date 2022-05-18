class AddColorToSkill < ActiveRecord::Migration[6.1]
  def change
    add_column :skills, :color, :integer, null: false, default: 0
  end
end
