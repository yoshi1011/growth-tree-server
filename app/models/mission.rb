# frozen_string_literal: true

# == Schema Information
#
# Table name: missions
#
#  id                                       :bigint           not null, primary key
#  description                              :text
#  name                                     :string           not null
#  created_at                               :datetime         not null
#  updated_at                               :datetime         not null
#  company_id(ミッションを登録している企業) :bigint
#
# Indexes
#
#  index_missions_on_company_id  (company_id)
#
# Foreign Keys
#
#  fk_rails_...  (company_id => companies.id)
#
class Mission < ApplicationRecord
  has_many :set_missions, dependent: :destroy
  has_many :curriculums, through: :set_missions
  has_many :set_tasks, dependent: :destroy
  has_many :tasks, through: :set_tasks
  has_many :skill_points, dependent: :destroy
  has_many :attachments, as: :source

  belongs_to :company
end
