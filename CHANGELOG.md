# Changelog - yard-sequel

## 0.X.X

### Pending Release

- groups association methods
- expands the parsing of  `:class` and `:class_namespace` options:
  - the namespace can now also be passed with the `:class` option
  - the fully qualified class name is now only used in @param and @return types
    (the class name without namespace is used in the documentation text)

### 0.1.1 (2018-12-04)

- adds this changelog
- parses option parameters for `:class` and `:class_namespace`
- lowers dependencies

### 0.1.0

- parses `one_to_many` and `many_to_one` method calls
- parses first parameter only
