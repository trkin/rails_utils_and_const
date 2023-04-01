# https://stackoverflow.com/a/73739642/287166
class Class
  def casting_attr_accessor(*accessors, type)
    Array(accessors).each do |accessor|
      define_method(accessor) do
        instance_variable_get("@#{accessor}")
      end

      define_method("#{accessor}=") do |val|
        instance_variable_set("@#{accessor}", Kernel.send(type.to_s, val)) unless val.nil?
      end
    end
  end
end
