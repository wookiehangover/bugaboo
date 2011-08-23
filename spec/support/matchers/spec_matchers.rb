RSpec::Matchers.define :exist_in_database do

  match do |actual|
    actual.class.exists?(actual.id)
  end

end

RSpec::Matchers.define :be_soft_deleted do

  match do |record|
    record.deleted_at != nil
  end

end
