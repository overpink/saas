# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require 'spec_helper'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
require 'database_cleaner'
require 'shoulda/matchers'
require 'factory_girl_rails'

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, :type => :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!


  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  # Include Factory Girl syntax to simplify calls to factories
  config.include FactoryGirl::Syntax::Methods
  config.include Devise::TestHelpers, type: :controller
  config.include ApplicationHelper
end

def create_user
  Rails.cache.clear
  @user = create(:user)
  @tenant = create(:tenant)
  @user.add_role(:owner, @tenant)
end

def signin
  create_user
  sign_in @user
end

# Don't need passwords in test DB to be secure, but we would like 'em to be
# fast -- and the stretches mechanism is intended to make passwords
# computationally expensive.

module Devise
  module Models
    module DatabaseAuthenticatable
      protected

      def password_digest(password)
        password
      end
    end
  end
end

Devise.setup do |config|
  config.stretches = Rails.env.test? ? 0 : 10
end
