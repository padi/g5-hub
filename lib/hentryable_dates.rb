module HentryableDates
  def created_at_computer_readable
    model.created_at.utc.to_s(:computer)
  end

  def created_at_human_readable
    model.created_at.to_s(:human)
  end
end
