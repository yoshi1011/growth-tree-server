# frozen_string_literal: true

# == Schema Information
#
# Table name: assigned_tasks
#
#  id                                        :bigint           not null, primary key
#  completed                                 :boolean          default(FALSE), not null
#  end_datetime                              :datetime         not null
#  start_datetime                            :datetime         not null
#  created_at                                :datetime         not null
#  updated_at                                :datetime         not null
#  set_task_id                               :bigint
#  user_id(タスクを割り当てられた従業員のID) :bigint
#
# Indexes
#
#  index_assigned_tasks_on_set_task_id  (set_task_id)
#  index_assigned_tasks_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (set_task_id => set_tasks.id)
#  fk_rails_...  (user_id => users.id)
#
class AssignedTask < ApplicationRecord
  has_many :comments, dependent: :destroy

  belongs_to :set_task
  belongs_to :employee, class_name: "User", foreign_key: "user_id"
end
