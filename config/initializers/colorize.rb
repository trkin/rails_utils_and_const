# https://github.com/duleorlovic/rails_utils_and_const/blob/main/config/initializers/colorize.rb
class String
  COLOR = 31 # red

  def red
    "\e[#{COLOR}m#{self}\e[0m"
  end

  # Show matched string in red color (plain search, not regexp):
  #
  #   my_str = "1: Hi\n2:\n3: Lorem ipsum\n4: This is my_search line"
  #
  #   my_str.colorize "my_search"
  #     # this will return whole string:
  #     1: Hi
  #     2:
  #     3: Lorem ipsum
  #     4: This is my_search line
  #
  #   my_str.colorize "my_search", only: true
  #     4: This is my_search line
  #
  def colorize(string, only: false, return_nil_for_test: true)
    last_index = 0
    res = ''
    while (new_index = self[last_index..].index(string))
      res += self[last_index..last_index + new_index - 1] if last_index + new_index - 1 > -1
      res += string.red
      last_index = last_index + new_index + string.length
    end
    res += self[last_index..]
    res = res.split("\n").select { |l| l.index string }.join("\n") if only
    puts res
    return_nil_for_test ? nil : res
  end
end

# run tests with a command
# rails test config/initializers/colorize.rb
# require 'minitest/autorun'
# class Test < Minitest::Test
#   def test_one_substring
#     s = 'My name is John.'
#     assert_equal "My name is \e[31mJohn\e[0m.", s.colorize('John', return_nil_for_test: false)
#   end
#
#   def test_two_substrings
#     s = 'John is my name, John.'
#     r = "\e[31mJohn\e[0m is my name, \e[31mJohn\e[0m."
#     assert_equal r, s.colorize('John', return_nil_for_test: false)
#   end
#
#   def test_no_found
#     s = 'My name is John.'
#     assert_equal "My name is John.", s.colorize('Mike', return_nil_for_test: false)
#   end
#
#   def test_whole
#     s = 'My name is John.'
#     assert_equal "\e[31mMy name is John.\e[0m", s.colorize(s, return_nil_for_test: false)
#   end
#
#   def test_return
#     s = 'My name is John.'
#     assert_nil s.colorize('John')
#   end
#
#   def test_only_matched_lines
#     s = "first_line\nsecond_line John\nthird_line\nJohn fourth_line"
#     assert_equal "second_line #{'John'.red}\n#{'John'.red} fourth_line", s.colorize('John', only: true, return_nil_for_test: false)
#   end
# end
