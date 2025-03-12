# Rails Utils and Const

Here is the collection of utils that you can use in your project

Code is stored in github repository

<https://github.com/trkin/rails_utils_and_const>

Install utils with copy paste interesting code or using cli

```
curl https://raw.githubusercontent.com/trkin/rails_utils_and_const/main/lib/lib_utils.rb > lib/lib_utils.rb
```

and than load in your rails configuration
```
# config/application.rb
    config.eager_load_paths << Rails.root.join("lib")
```


## Tips

* Const

  TODO: `bundle exec rake active_record_doctor` should work

* Rails enums

  ```
  # app/models/post.rb
  class Post < ApplicationRecord
    enum status: LibUtils.convert_array_to_hash(%w[active admin inactive])
  ```

* Inspecting strings `config/initializers/colorize.rb`
  ```
  my_str.colorize "my_search"
  my_str.colorize "my_search", only: true

  # in test
  assert_match /m_first.*m_second.*m_third/m, response.body, response.body.colorize("m_", only: true)
  ```
  TODO: lines: 2

* LibUtils `lib/lib_utils.rb`
  ```
  my_hash = { a: { b: 1 } }
  LibUtils.hash_add_keys my_hash
    {"a"=>{"a b"=>1}}

  JSON.pretty_generate(LibUtils.hash_add_keys(my_hash)).colorize "my_search", only: true

  ```
* LibUtils for console aliases `config/initializers/my_aliases.rb` and
  `config/initializers/console_helpers.rb`
  ```
  rails c
  me
  ```

* Result and Error `config/initializers/result_and_error.rb`
  ```
  # app/services/my_service.rb

  Result.new "OK", name: name
  ```

* Services `app/services/my_service.rb`

* Forms `app/forms/registration_form.rb`

* Date Time formats `config/initializers/date_time_formats.rb`

* Silent SQL log `config/initializers/silent_sql_log.rb`
  ```
  SILENT_SQL_LOG=true rails s

  # also works for test
  export SILENT_SQL_LOG=true
  rails test
  ```
  If you really need you can
  enable action cable log `config/initializers/enable_action_cable_log.rb`
  enable active storage log `config/initializers/enable_active_storage_log.rb`
  ```
  ENABLE_ACTION_CABLE_LOG=true ENABLE_ACTIVE_STORAGE_LOG=true rails s
  ```
