# frozen_string_literal: true

# == Schema Information
#
# Table name: curriculums
#
#  id                                         :bigint           not null, primary key
#  description                                :text
#  name                                       :string           not null
#  created_at                                 :datetime         not null
#  updated_at                                 :datetime         not null
#  company_id(カリキュラムを登録している企業) :bigint
#
# Indexes
#
#  index_curriculums_on_company_id  (company_id)
#
# Foreign Keys
#
#  fk_rails_...  (company_id => companies.id)
#
class Curriculum < ApplicationRecord
  has_many :assigned_curriculums, dependent: :destroy
  has_many :employees, through: :assigned_curriculums
  has_many :set_missions, dependent: :destroy
  has_many :missions, through: :set_missions
  has_many :attachments, as: :source

  belongs_to :company

  def set_mission(mission)
    missions << mission
  end

  def remove_mission(mission)
    set_missions.find_by(mission_id: mission.id).destroy
  end
end
