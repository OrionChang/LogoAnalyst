class Answer
  include Mongoid::Document
  include Mongoid::Timestamps

  field :answer_content, type: String

  embedded_in :question
end