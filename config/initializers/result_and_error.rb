# https://github.com/duleorlovic/rails_utils_and_const/blob/main/config/initializers/result_and_error.rb
class Result
  attr_accessor :message, :data

  # Use this to class to return results from service:
  #
  #   class MyService
  #     def perform
  #       if true
  #         Result.new "Next task created", next_task: next_task
  #       else
  #         Error.new "Failed"
  #       end
  #     end
  #   end
  #
  # and use in controller:
  #
  #   result = MyService.new.perform
  #   if result.success?
  #     flash[:notice] = result.message
  #     redirect_to result.data[:next_task]
  #   end
  #
  # Note when iterating a huge objects, use `next_task_id` so Ruby Garbage
  # Collector can clear all temp objects from the service run
  # If you return some object which is not basic, it can not safely clear all
  # temp objects
  #
  def initialize(message, data = {})
    @message, @data = message, data
  end

  def success?
    true
  end
end

class Error < Result
  def success?
    false
  end
end
