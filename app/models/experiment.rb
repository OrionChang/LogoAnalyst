class Experiment
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :times, type: Integer
end
