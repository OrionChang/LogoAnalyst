class Survey
  include Mongoid::Document
  include Mongoid::Timestamps

  field :other, type: String

  belongs_to :profile
  belongs_to :answer


  after_create :inc_count
  after_destroy :dec_count

  def inc_count
    self.profile.inc(:counter, 1)
    self.answer.inc(:counter, 1)
  end

  def dec_count
    self.profile.inc(:counter, -1)
    self.answer.inc(:counter, -1)
  end

end
