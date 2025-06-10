# 1. Test terraform functions

1.1 Run the following command
```
terraform console
```

1.2 Run the functions 
```
upper("karim")
replace("hello world", "world", "Terraform")
join("-", ["dev", "staging", "prod"])
min(10, 5, 20)
max(1, 7, 3) 
abs(-42)
timestamp()
length(["a", "b", "c"])
lookup({a = 1, b = 2}, "b", 0)
merge({a = 1}, {b = 2})
```