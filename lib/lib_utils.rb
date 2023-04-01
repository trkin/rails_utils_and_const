module LibUtils
  # You can use LibUtils.method instead of LibUtils::method
  extend self

  # It is easier to use strings than numbers so use this to easy define hash
  # enum status: LibUtils.convert_array_to_hash(%w[active admin inactive])
  # instead of writting
  # enum status: {active: "active", admin: "admin", inactive: "inactive"}
  # Note that you can use Post.statuses["active"] or Post.statuses[:active]
  def self.convert_array_to_hash(array)
    array.each_with_object({}) { |k, o| o[k.to_s] = k.to_s }
  end

  # Same as convert_array_to_hash but the input is list separated by new lines
  def self.split_and_convert_to_hash(string)
    convert_array_to_hash string.split("\n")
  end
end
