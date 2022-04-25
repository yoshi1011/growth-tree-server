# frozen_string_literal: true

# == Schema Information
#
# Table name: skill_points
#
#  id                                                      :bigint           not null, primary key
#  point(そのミッションを通じて獲得できるスキルのポイント) :integer
#  created_at                                              :datetime         not null
#  updated_at                                              :datetime         not null
#  mission_id(スキルポイントを獲得できるミッションのID)    :bigint
#  skill_id                                                :bigint
#
# Indexes
#
#  index_skill_points_on_mission_id  (mission_id)
#  index_skill_points_on_skill_id    (skill_id)
#
# Foreign Keys
#
#  fk_rails_...  (mission_id => missions.id)
#  fk_rails_...  (skill_id => skills.id)
#
class SkillPoint < ApplicationRecord
  belongs_to :skill
  belongs_to :mission
end
