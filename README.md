# Rails helpers and const

Inspecting strings `config/initializers/colorize.rb`
```
my_str.colorize "my_search"
my_str.colorize "my_search", only: true
```

Helpers `config/initializers/helpers.rb`
```
my_hash = { a: { b: 1 } }
Helpers.hash_add_keys my_hash
  {"a"=>{"a b"=>1}}
```

Pretty print json

```
my_hash = { "a" => { b: "2" } }
JSON.pretty_generate my_hash
```

You can use colorize and `Helpers.hash_add_keys`
```
JSON.pretty_generate(Helpers.hash_add_keys(my_hash)).colorize "my_search", only: true
```
