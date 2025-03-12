# https://trk.codes/rails_utils_and_const/lib/lib_utils.rb
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
  # enum kind: split_and_convert_to_hash(<<~TEXT)
  #   admin
  # TEXT
  def self.split_and_convert_to_hash(string)
    convert_array_to_hash string.split("\n")
  end

  def self.deep_symbolize_keys(object)
    case object
    when Hash
      object.each_with_object({}) do |(key, value), result|
        result[key.to_sym] = deep_symbolize_keys(value)
      end
    when Array
      object.map { |e| deep_symbolize_keys(e) }
    else
      object
    end
  end

  # Add previous keys to hash, usefull for nested json
  #   my_hash = { a: { b: 1 } }
  #   LibUtils.hash_add_keys my_hash
  #     {"a"=>{"a b"=>1}}
  #
  # Save and load hash from file:
  #   File.write 'tmp/my_hash', my_hash.to_json, mode: 'a'
  #   my_hash = JSON.parse File.read("tmp/my_hash")
  #
  # Pretty print json
  #   my_hash = { "a" => { b: "2" } }
  #   puts JSON.pretty_generate my_hash
  #   # in html
  #   <%= JSON.pretty_generate(my_hash).gsub("\n", "<br>").gsub(" ", "&nbsp;").html_safe %>
  #
  # Use with colorize:
  #   JSON.pretty_generate(LibUtils.hash_add_keys(my_hash)).colorize "my_search", only: true
  def self.hash_add_keys(object, path_to_here = "")
    case object
    when Hash
      object.each_with_object({}) do |(k, v), a|
        new_path = "#{path_to_here} #{k}".strip
        a[new_path] = hash_add_keys(v, new_path)
      end
    when Array
      object.map.with_index do |o, i|
        new_path = "#{path_to_here} #{i}".strip
        hash_add_keys o, new_path
      end
    else
      object
    end
  end

  # https://fractaledmind.com/articles/safely-accessing-values-from-a-nested-hash-again/
  # Since dig can raise exception:
  # hash = { a: { b: "string" }, items: [{"id": "first"}] }
  # hash.dig :a, :b, :c
  # => String does not have #dig method (TypeError)
  # safe_dig does not raise
  # LibUtils.safe_dig hash, %w[a b c]
  # => nil
  # and also works for arrays "0" is [0]
  # LibUtils.safe_dig hash, %w[items 0 id]
  # => first
  def self.safe_dig(hash, keypath, default = nil)
    stringified_hash = JSON.parse(hash.to_json)
    stringified_keypath = keypath.map(&:to_s)

    stringified_keypath.reduce(stringified_hash) do |accessible, key|
      if accessible.is_a?(Array) && key == "0"
        accessible[0]
      else
        return default unless accessible.is_a? Hash
        return default unless accessible.key? key

        accessible[key]
      end
    end
  end

  # Show non inherited instance methods for the object
  def self.methods(object)
    object.class.instance_methods(false)
  end
end
