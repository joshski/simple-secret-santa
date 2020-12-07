class Player < ApplicationRecord
  belongs_to :game
  belongs_to :recipient, class_name: 'Player', optional: true
  has_one :sender, class_name: 'Player', foreign_key: 'recipient_id'

  before_create do
    self.uuid = SecureRandom.uuid
  end

  def to_param
    uuid
  end

  def self.from_param(uuid)
    find_by!(uuid: uuid)
  end
end
