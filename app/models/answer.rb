class Answer
  include Mongoid::Document
  include Mongoid::Timestamps


  field :answer_content, type: String

  embedded_in :question
  has_many :surveys


  include Counter
  after_create :inc_count
  after_destroy :dec_count


end