module HentryableDates
  def created_at_computer_readable
    model.created_at.utc.to_s(:computer)
  end

  def created_at_human_readable
    model.created_at.to_s(:human)
  end

  def urn
    "#{record_type}-#{model.id}-#{model.name.parameterize}"
  end

  def to_param
    urn
  end
end
