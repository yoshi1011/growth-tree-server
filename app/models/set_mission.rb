# frozen_string_literal: true

# == Schema Information
#
# Table name: set_missions
#
#  id            :bigint           not null, primary key
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  curriculum_id :bigint
#  mission_id    :bigint
#
# Indexes
#
#  index_set_missions_on_curriculum_id  (curriculum_id)
#  index_set_missions_on_mission_id     (mission_id)
#
# Foreign Keys
#
#  fk_rails_...  (curriculum_id => curriculums.id)
#  fk_rails_...  (mission_id => missions.id)
#
class SetMission < ApplicationRecord
  has_many :assigned_missions, dependent: :destroy

  belongs_to :curriculum
  belongs_to :mission
end
