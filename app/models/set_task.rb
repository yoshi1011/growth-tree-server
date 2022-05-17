# frozen_string_literal: true

# == Schema Information
#
# Table name: set_tasks
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  mission_id :bigint
#  task_id    :bigint
#
# Indexes
#
#  index_set_tasks_on_mission_id  (mission_id)
#  index_set_tasks_on_task_id     (task_id)
#
# Foreign Keys
#
#  fk_rails_...  (mission_id => missions.id)
#  fk_rails_...  (task_id => tasks.id)
#
class SetTask < ApplicationRecord
  belongs_to :mission
  belongs_to :task

  validates :mission_id, uniqueness: { scope: :task_id }
end
