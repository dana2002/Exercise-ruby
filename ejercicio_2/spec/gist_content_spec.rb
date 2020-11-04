require_relative '../gist_content'
require 'spec_helper'

describe Received_values do
  let(:path) { '../ejercicio_2/spec/test' }
  let(:description) { 'description' }
  let(:state) { true }
  
  describe '#path_existence' do
    context 'when valid' do
      it 'calls the body method' do
        values = Received_values.new(path, description, state)
        expect(values).to receive(:body)

        values.path_existence
      end
    end

    context 'when invalid' do
      it 'outputs message' do
        path_invalid = 'invalid path/'

        values = Received_values.new(path_invalid, description, state)
        expect { values.path_existence }.to output("The path does not exist\n").to_stdout
      end
    end
  end

  describe '#body' do
    it 'calls the read_path method' do
      values = Received_values.new(path, description, state)

      expect(values).to receive(:read_path)
      values.body
      expect(values.data).should_not be_nil
    end
    
    it 'hashes receives values' do
      values = Received_values.new(path, description, state)

      values.body
      expect(values.data).to eq({"description"=>"description", "files"=>{"test.rb"=>{"content"=>"puts \"Hello world\""}}, "public"=>true})
    end
  end

  describe '#read_path' do
    it 'completes the hash for each iteration' do
      values = Received_values.new(path, description, state)

      values.body
      expect(values.data).to eq({"description"=>"description", "files"=>{"test.rb"=>{"content"=>"puts \"Hello world\""}}, "public"=>true})
    end

    it 'pass a path without files' do
      path = '../ejercicio_2/spec/test_2'
      values = Received_values.new(path, description, state)

      values.body
      expect(values.data).to eq({"description"=>"description", "files"=>{}, "public"=>true})  
    end 
  end  
end
