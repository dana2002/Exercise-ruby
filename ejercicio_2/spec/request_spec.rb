require_relative '../request'
require 'spec_helper'

describe Assemble do
  describe '#request' do
    it 'the request is made' do
      data = { "description"=>"description", 'public' => true, "files"=>{ "test.rb"=>{ "content"=>"puts \"Hello world\"" } }}
      request = Assemble.new(data)

      request.request
      expect(request.response.code).to eq("201")
    end

    it 'the request is not made if data is empty' do
      data = {}

      request = Assemble.new(data)
      request.request
      expect(request.response.code).to eq("422")
    end
  end
end