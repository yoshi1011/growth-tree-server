# frozen_string_literal: true

# == Schema Information
#
# Table name: curriculums
#
#  id                                         :bigint           not null, primary key
#  description                                :text
#  name                                       :string
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
  has_many :set_missions, dependent: :destroy
  has_many :missions, through: :set_missions
  has_many :attachments, as: :source

  belongs_to :company
end
