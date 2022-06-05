# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                                              :bigint           not null, primary key
#  allow_password_change                           :boolean          default(FALSE)
#  birthday                                        :date             not null
#  confirmation_sent_at                            :datetime
#  confirmation_token                              :string
#  confirmed_at                                    :datetime
#  email                                           :string           not null
#  encrypted_password                              :string           default(""), not null
#  failed_attempts                                 :integer          default(0), not null
#  first_name                                      :string           not null
#  image_url                                       :string
#  joined_date(入社日)                             :date
#  last_name                                       :string           not null
#  locked_at                                       :datetime
#  provider                                        :string           default("email"), not null
#  remember_created_at                             :datetime
#  reset_password_sent_at                          :datetime
#  reset_password_token                            :string
#  role(Manager, Employeeなどを区別するための項目) :integer          default("manager"), not null
#  tokens                                          :json
#  uid                                             :string           default(""), not null
#  unconfirmed_email                               :string
#  unlock_token                                    :string
#  created_at                                      :datetime         not null
#  updated_at                                      :datetime         not null
#  company_id                                      :bigint
#  manager_id                                      :bigint
#
# Indexes
#
#  index_users_on_company_id            (company_id)
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_manager_id            (manager_id)
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_uid_and_provider      (uid,provider) UNIQUE
#  index_users_on_unlock_token          (unlock_token) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (company_id => companies.id)
#  fk_rails_...  (manager_id => users.id)
#
class User < ActiveRecord::Base
  include DeviseTokenAuth::Concerns::User
  # フロントエンド側からBASE64データで画像を受信するためcarrierwave-base64を導入し実装
  mount_base64_uploader :image_url, AccountImageUploader

  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable,
         :confirmable,
         :lockable

  has_many :assigned_curriculums, dependent: :destroy
  has_many :curriculums, class_name: "Curriculum", through: :assigned_curriculums
  has_many :assigned_missions, dependent: :destroy
  has_many :missions, class_name: "Mission", through: :assigned_missions
  has_many :assigned_tasks, dependent: :destroy
  has_many :tasks, class_name: "Task", through: :assigned_tasks
  has_many :owned_skills
  has_many :employees, class_name: "User", foreign_key: "manager_id"

  belongs_to :company, optional: true
  belongs_to :manager, class_name: "User", optional: true

  enum role: [:manager, :employee]

  def name
    "#{first_name} #{last_name}"
  end
end
