class Survey
  include Mongoid::Document
  include Mongoid::Timestamps

  field :other, type: String

  belongs_to :profile
  belongs_to :answer

  #TODO minimize database problem
  after_create :inc_count
  after_destroy :dec_count

  def inc_count
    Question.where('answers._id' => Moped::BSON::ObjectId(self.answer_id))[0].answers.where(:id => self.answer_id).first.inc(:counter, 1)
    Company.where('profiles._id' => Moped::BSON::ObjectId(self.profile_id))[0].profiles.where(:id => self.profile_id).first.inc(:counter, 1)
  end

  def dec_count
    Company.where('profiles._id' => Moped::BSON::ObjectId(self.profile_id))[0].profiles.where(:id => self.profile_id).first.inc(:counter, -1)
    Question.where('answers._id' => Moped::BSON::ObjectId(self.answer_id))[0].answers.where(:id => self.answer_id).first.inc(:counter, -1)
  end

end
