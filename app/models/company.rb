# frozen_string_literal: true

# == Schema Information
#
# Table name: companies
#
#  id             :bigint           not null, primary key
#  address_line_1 :string
#  address_line_2 :string
#  city           :string           not null
#  image_url      :string
#  name           :string           not null
#  prefecture     :string           not null
#  zip_code       :string           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class Company < ApplicationRecord
  has_many :users, dependent: :destroy
  has_many :curriculums, dependent: :destroy
  has_many :missions, dependent: :destroy
  has_many :tasks, dependent: :destroy
  has_many :skills, dependent: :destroy
end
