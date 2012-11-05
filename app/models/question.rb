class Question
  include Mongoid::Document
  include Mongoid::Timestamps

  field :question_content, type: String

  embeds_many :answers, cascade_callbacks: true

  accepts_nested_attributes_for :answers, :allow_destroy => true, :reject_if => lambda { |a| a[:answer_content].blank? }
end