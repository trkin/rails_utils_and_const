module Const
  def self.my_important_string
    "chrome://version/"
  end

  # Add previous keys to hash, usefull for nested json
  #   my_hash = { a: { b: 1 } }
  #   Const.hash_add_keys my_hash
  #     {"a"=>{"a b"=>1}}
  #
  # Save and load hash from file:
  #   File.write 'tmp/my_hash', my_hash.to_json, mode: 'a'
  #   my_hash = JSON.parse File.read("tmp/my_hash")
  #
  # Use with colorize:
  #   JSON.pretty_generate(Const.hash_add_keys(my_hash)).colorize "my_search", only: true
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
end
