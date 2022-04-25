# frozen_string_literal: true

# == Schema Information
#
# Table name: attachments
#
#  id                                     :bigint           not null, primary key
#  name                                   :string
#  source_type                            :string
#  url                                    :string
#  created_at                             :datetime         not null
#  updated_at                             :datetime         not null
#  source_id(Task, Commentなど複数で利用) :bigint
#
# Indexes
#
#  index_attachments_on_source  (source_type,source_id)
#
class Attachment < ApplicationRecord
  belongs_to :source, polymorphic: true
end
