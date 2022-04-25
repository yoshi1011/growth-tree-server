# frozen_string_literal: true

# == Schema Information
#
# Table name: comments
#
#  id                                  :bigint           not null, primary key
#  content                             :text
#  created_at                          :datetime         not null
#  updated_at                          :datetime         not null
#  assigned_task_id                    :bigint
#  user_id(コメントをするユーザーのID) :bigint
#
# Indexes
#
#  index_comments_on_assigned_task_id  (assigned_task_id)
#  index_comments_on_user_id           (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (assigned_task_id => assigned_tasks.id)
#  fk_rails_...  (user_id => users.id)
#
class Comment < ApplicationRecord
  has_many :attachments, as: :source

  belongs_to :assigned_task
  belongs_to :user
end
