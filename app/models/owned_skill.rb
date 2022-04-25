# frozen_string_literal: true

# == Schema Information
#
# Table name: owned_skills
#
#  id                                        :bigint           not null, primary key
#  point(スキルの習得率 0〜100点)            :integer
#  created_at                                :datetime         not null
#  updated_at                                :datetime         not null
#  skill_id                                  :bigint
#  user_id(スキルを所有しているユーザーのID) :bigint
#
# Indexes
#
#  index_owned_skills_on_skill_id  (skill_id)
#  index_owned_skills_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (skill_id => skills.id)
#  fk_rails_...  (user_id => users.id)
#
class OwnedSkill < ApplicationRecord
  belongs_to :skill
  belongs_to :user
end
