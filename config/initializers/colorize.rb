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
  #     5: Last line
  #
  #   my_str.colorize "my_search", only: true
  #     4: This is my_search line
  #
  #   my_str.colorize "my_search", only: 1
  #     3: Lorem ipsum
  #     4: This is my_search line
  #     5: Last line
  #
  def colorize(string, only: false, return_res_for_test: false)
    last_index = 0
    res = ""
    while (new_index = self[last_index..].index(string))
      res += self[last_index..last_index + new_index - 1] if last_index + new_index - 1 > -1
      res += string.red
      last_index = last_index + new_index + string.length
    end
    res += self[last_index..]
    if only
      around = (only == true) ? 0 : only.to_i
      lines = res.split("\n")
      matched_indices = lines.each_index.select { |i| lines[i].include? string }
      indices_around = matched_indices.each_with_object([]) do |index, acc|
        range_start = [0, index - around].max
        range_end = [lines.length - 1, index + around].min
        (range_start..range_end).each { |i| acc.push(i) }
      end
      res = indices_around.uniq.sort.map { |i| lines[i] }.join("\n")
    end
    puts res
    return_res_for_test ? res : nil
  end
end

# # run tests with a command
# # rails test config/initializers/colorize.rb
# require 'minitest/autorun'
# class Test < Minitest::Test
#   def test_one_substring
#     s = 'My name is John.'
#     assert_equal "My name is \e[31mJohn\e[0m.", s.colorize('John', return_res_for_test: true)
#   end

#   def test_two_substrings
#     s = 'John is my name, John.'
#     r = "\e[31mJohn\e[0m is my name, \e[31mJohn\e[0m."
#     assert_equal r, s.colorize('John', return_res_for_test: true)
#   end

#   def test_no_found
#     s = 'My name is John.'
#     assert_equal "My name is John.", s.colorize('Mike', return_res_for_test: true)
#   end

#   def test_whole
#     s = 'My name is John.'
#     assert_equal "\e[31mMy name is John.\e[0m", s.colorize(s, return_res_for_test: true)
#   end

#   def test_return_nil
#     s = 'My name is John.'
#     assert_nil s.colorize('John')
#   end

#   def test_only_matched_lines_single
#     s = "first_line\nsecond_line John\nthird_line\nJohn fourth_line"
#     assert_equal "second_line #{'John'.red}\n#{'John'.red} fourth_line", s.colorize('John', only: true, return_res_for_test: true)
#   end

#   def test_only_matched_lines_around
#     s = "first_line\nsecond_line John\nthird_line\nJohn fourth_line"
#     assert_equal "first_line\n#{'second_line'.red} John\nthird_line", s.colorize('second_line', only: 1, return_res_for_test: true)
#   end
# end
