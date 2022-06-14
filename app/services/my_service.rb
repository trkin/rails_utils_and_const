class MyService
  def initialize(user = nil)
    @user = user
  end

  def perform(name = nil)
    return Error.new "Name is blank" if name.blank?

    # do something with @user and name

    Result.new "OK", name: name
  end
end
