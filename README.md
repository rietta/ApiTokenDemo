# API Token Demo

This is a demo to discuss a concept.

It's available free to the public at https://github.com/rietta/ApiTokenDemo.

This is an example that was not TTD. That is left as an exercise to the reader.

## Generate a token
```ruby
  puts ApiToken.create.generated_token
```

That will generate a new token, persist it to the database, and return the generated token once. Every call will generate a brand new token. The generated_token is not persisted to the database in plaintext.

The generated token will look like this:

```
eac4d6c04e6f4658977fbcc1448c6ae3:096fabb7192b99fc817c30f3cecc4c5c06583f338be0efe2d6e69027c532977c2b48fb0d4a785d3c8cc0651989cff5f19027eb2a35a96a65
```


## Further reading

- [Does a UUID make a secure API token for an Android or iOS application's API RESTful endpoints? (video)](https://vimeo.com/127221515)
- [Ruby on Rails 4.1.1: ActiveModel::SecurePassword::ClassMethods](http://api.rubyonrails.org/classes/ActiveModel/SecurePassword/ClassMethods.html)