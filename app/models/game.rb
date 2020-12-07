class Game < ApplicationRecord
  has_many :players

  accepts_nested_attributes_for :players, allow_destroy: true

  before_validation do
    self.players = players.reject { |player| player.name.blank? }
  end

  before_create do
    self.uuid = SecureRandom.uuid
  end

  after_create do
    shuffled = shuffle_players
    shuffled.each_with_index do |p, i|
      p.update!(recipient: shuffled[(i + 1) % self.players.size])
    end
  end

  def to_param
    uuid
  end

  def self.from_param(uuid)
    find_by!(uuid: uuid)
  end

  private

  def shuffle_players
    if Rails.env.test?
      players
    else
      players.shuffle
    end
  end
end
