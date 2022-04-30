# frozen_string_literal: true

# == Schema Information
#
# Table name: tasks
#
#  id                                   :bigint           not null, primary key
#  description                          :text
#  must_be_submitted                    :boolean          default(FALSE), not null
#  name                                 :string           not null
#  created_at                           :datetime         not null
#  updated_at                           :datetime         not null
#  company_id(タスクを登録している企業) :bigint
#
# Indexes
#
#  index_tasks_on_company_id  (company_id)
#
# Foreign Keys
#
#  fk_rails_...  (company_id => companies.id)
#
class Task < ApplicationRecord
  has_many :set_tasks, dependent: :destroy
  has_many :missions, through: :set_tasks
  has_many :attachments, as: :source

  belongs_to :company
end
