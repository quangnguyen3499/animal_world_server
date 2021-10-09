class Graph::Base
  include Base
  include Graph::Const

  def initialize object, *_args
    @data = object
  end
end