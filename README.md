# Rails Utils and Const

Here is the collection of utils that you can use in your project

Code is stored in github repository

<https://github.com/trkin/rails_utils_and_const>

Install utils with copy paste interesting code or using cli

```
curl 
```

and than load in your rails configuration
```
# config/application.rb
    config.eager_load_paths << Rails.root.join("lib")
```


## Tips

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
  ```

* Helpers `config/initializers/helpers.rb`
  ```
  my_hash = { a: { b: 1 } }
  Helpers.hash_add_keys my_hash
    {"a"=>{"a b"=>1}}

  JSON.pretty_generate(Helpers.hash_add_keys(my_hash)).colorize "my_search", only: true

  ```
* Helpers for console aliases `config/initializers/my_aliases.rb`
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
