# frozen_string_literal: true

# == Schema Information
#
# Table name: assigned_missions
#
#  id                                            :bigint           not null, primary key
#  completed                                     :boolean          default(FALSE), not null
#  end_datetime                                  :datetime
#  start_datetime                                :datetime
#  created_at                                    :datetime         not null
#  updated_at                                    :datetime         not null
#  set_mission_id                                :bigint
#  user_id(ミッションを割り当てられた従業員のID) :bigint
#
# Indexes
#
#  index_assigned_missions_on_set_mission_id  (set_mission_id)
#  index_assigned_missions_on_user_id         (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (set_mission_id => set_missions.id)
#  fk_rails_...  (user_id => users.id)
#
class AssignedMission < ApplicationRecord
  belongs_to :set_mission
  belongs_to :employee, class_name: "User", foreign_key: "user_id"
end
