# frozen_string_literal: true

# == Schema Information
#
# Table name: assigned_missions
#
#  id                                            :bigint           not null, primary key
#  completed                                     :boolean          default(FALSE), not null
#  end_datetime                                  :datetime         not null
#  start_datetime                                :datetime         not null
#  created_at                                    :datetime         not null
#  updated_at                                    :datetime         not null
#  assigned_curriculum_id                        :bigint
#  mission_id                                    :bigint
#  user_id(ミッションを割り当てられた従業員のID) :bigint
#
# Indexes
#
#  index_assigned_missions_on_assigned_curriculum_id  (assigned_curriculum_id)
#  index_assigned_missions_on_mission_id              (mission_id)
#  index_assigned_missions_on_user_id                 (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (assigned_curriculum_id => assigned_curriculums.id)
#  fk_rails_...  (mission_id => missions.id)
#  fk_rails_...  (user_id => users.id)
#
class AssignedMission < ApplicationRecord
  has_many :assigned_tasks, dependent: :destroy

  belongs_to :assigned_curriculum
  belongs_to :mission
  belongs_to :employee, class_name: "User", foreign_key: "user_id"
end
