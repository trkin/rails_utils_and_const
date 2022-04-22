# Rails helpers and const

Inspecting strings `config/initializers/colorize.rb`
```
my_str.colorize "my_search"
my_str.colorize "my_search", only: true
```

Inspecting long json

```
my_hash = { "a" => { b: "2" } }
JSON.pretty_generate my_hash
```

You can use colorize and add_keys
```
JSON.pretty_generate Const.add_keys(my_hash)

# use colorize to see only matched lines
JSON.pretty_generate(Const.add_keys(my_hash)).colorize "my_search", only: true
```
