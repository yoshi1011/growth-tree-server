# frozen_string_literal: true

# == Schema Information
#
# Table name: skills
#
#  id                                   :bigint           not null, primary key
#  description                          :text
#  name                                 :string
#  created_at                           :datetime         not null
#  updated_at                           :datetime         not null
#  company_id(スキルを登録している企業) :bigint
#
# Indexes
#
#  index_skills_on_company_id  (company_id)
#
# Foreign Keys
#
#  fk_rails_...  (company_id => companies.id)
#
class Skill < ApplicationRecord
  has_many :skill_points, dependent: :destroy
  has_many :owned_skills

  belongs_to :company
end
