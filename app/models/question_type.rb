class QuestionType
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  # To change this template use File | Settings | File Templates.
end