# frozen_string_literal: true

# == Schema Information
#
# Table name: assigned_curriculums
#
#  id                                              :bigint           not null, primary key
#  completed                                       :boolean          default(FALSE), not null
#  end_datetime                                    :datetime         not null
#  start_datetime                                  :datetime         not null
#  created_at                                      :datetime         not null
#  updated_at                                      :datetime         not null
#  curriculum_id                                   :bigint
#  user_id(カリキュラムを割り当てられた従業員のID) :bigint
#
# Indexes
#
#  index_assigned_curriculums_on_curriculum_id  (curriculum_id)
#  index_assigned_curriculums_on_user_id        (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (curriculum_id => curriculums.id)
#  fk_rails_...  (user_id => users.id)
#
class AssignedCurriculum < ApplicationRecord
  has_many :assigned_missions, dependent: :destroy

  belongs_to :curriculum
  belongs_to :employee, class_name: "User", foreign_key: "user_id"
end
