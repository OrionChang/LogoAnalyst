module Counter

  def inc_count
    self._parent.inc(:counter, 1)
  end

  def dec_count
    self._parent.inc(:counter, -1)
  end


end
