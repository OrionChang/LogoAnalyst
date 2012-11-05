class Response
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :other, type: String

  belongs_to :answer
  embedded_in :survey

end

