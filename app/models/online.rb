class Online < ActiveRecord::Base
  def self.now?(user)
    self.exists?(["user_id = ? and actived_at > ?", user.id, 30.minutes.ago])
  end
end
