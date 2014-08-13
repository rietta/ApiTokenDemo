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

    it 'The token key can be validated' do
      expect(ApiToken.find_by_token(@token_key)).to_not be_nil
    end

    it 'A modified key is invalid' do
      expect(ApiToken.find_by_token(@token_key.upcase)).to be_nil
    end

    it 'Looking up the token cannot retrieve the whole key' do
      expect(ApiToken.find_by_token(@token_key).generated_token).to be_nil
    end

  end # happy path

end