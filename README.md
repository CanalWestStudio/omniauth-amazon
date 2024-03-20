# OmniAuth::Amazon
[![Build Status](https://travis-ci.org/wingrunr21/omniauth-amazon.png)](https://travis-ci.org/wingrunr21/omniauth-amazon) [![Gem Version](https://badge.fury.io/rb/omniauth-amazon.png)](http://badge.fury.io/rb/omniauth-amazon)

[Login with Amazon Business](https://developer-docs.amazon.com/amazon-business/docs/website-authorization-workflow) OAuth2 strategy for OmniAuth 1.0

## Installation

Add this line to your application's Gemfile:

    gem 'omniauth-amazon'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install omniauth-amazon

## Prereqs

This gem is configured for use with Amazon Business [Onboarding Overview](https://developer-docs.amazon.com/amazon-business/docs/onboarding-overview).

    
    https://your_website_here/users/auth/amazon/callback

Amazon requires HTTPS for the whitelisted callback URL.

## Usage

Usage is similar to other OAuth2 based OmniAuth strategies:

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  config.omniauth provider, args[:public_key], args[:private_key], args[:options]
end
```

Credentials require authorize_params option

```yaml
amazon:
    public_key: ''
    private_key: '' 
    scope: 'profile' \\ check docs for your congirgurations
    state: ''
    authorize_params:
      applicationId: '' \\ required
      version: 'beta' \\ check app settings for your congirguration
```

## Configuration

Config options can be passed to `provider` via a `Hash`:

* `scope`: A space-separated list of permissions. Can be `profile`,
  `postal_code`, `profile:user_id`, or a combination of options.  
  Defaults to: `profile postal_code`
    * Requesting the `profile:user_id` scope will not display an additional consent
      screen the first time the user logs in.

## Resources
* [Login with Amazon button guide](https://login.amazon.com/button-guide)
* [Login with Amazon style guide](https://login.amazon.com/style-guide)


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
