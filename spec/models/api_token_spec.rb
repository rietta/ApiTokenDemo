require 'rails_helper'

describe ApiToken do

  context 'Token happy path' do

    before(:each) do
      @token = ::ApiToken.create
      @token_key = @token.generated_token
    end

    after(:each) do
      @token.destroy if @token and @token.persisted?
    end

    it 'Generates a new token of sufficient length' do
      expect(@token_key.length).to be >= 145
    end

  end

end