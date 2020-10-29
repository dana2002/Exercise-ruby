require_relative '../gist_content'
require 'spec_helper'

describe Received_values do
  describe '#path_existence' do
    context 'when valid' do
      it 'call the body method' do
        path = '../ejercicio_2/spec/test'
        description = 'description'
        state = true
        values = Received_values.new(path, description, state)
        expect(values).to receive(:body)

        values.path_existence
      end
    end

    context 'when invalid' do
      it 'the path does not exist' do
        path = 'invalid path/'
        description = 'description'
        state = true
        values = Received_values.new(path, description, state)
        expect { values.path_existence }.to output("The path does not exist\n").to_stdout
      end
    end
  end

  describe '#body' do
    it 'call the read_path method' do
      path = '../ejercicio_2/spec/test'
      description = 'description'
      state = true
      values = Received_values.new(path, description, state)

      expect(values).to receive(:read_path)
      values.body
      expect(values.data).should_not be_nil
    end
    
    it 'hash receives values' do
      path = '../ejercicio_2/spec/test'
      description = 'description'
      state = true
      values = Received_values.new(path, description, state)

      values.body
      expect(values.data).to eq({"description"=>"description", "files"=>{"test.rb"=>{"content"=>"puts \"Hello world\""}}, "public"=>true})
    end
  end

  describe '#read_path' do
    it 'for each iteration complete the hash' do
      path = '../ejercicio_2/spec/test'
      description = 'description'
      state = true
      values = Received_values.new(path, description, state)

      values.body
      expect(values.data).to eq({"description"=>"description", "files"=>{"test.rb"=>{"content"=>"puts \"Hello world\""}}, "public"=>true})
    end

    it 'when pass a path without files' do
      path = '../ejercicio_2/spec/test_2'
      description = 'description'
      state = true
      values = Received_values.new(path, description, state)

      values.body
      expect(values.data).to eq({"description"=>"description", "files"=>{}, "public"=>true})  
    end 
  end  
end
