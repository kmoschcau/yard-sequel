# frozen_string_literal: true
require 'yard'
require 'yard/parser/ruby/ast_node'

require_relative '../lib/yard-sequel/ast_hash'

class Ast
  extend YARD::Parser::Ruby
end

# rubocop:disable Metrics/BlockLength

RSpec.describe YardSequel::AstHash, '.new' do
  context 'passed nil' do
    it 'raises a TypeError' do
      expect { YardSequel::AstHash.new(nil) }.to raise_error TypeError
    end
  end

  context 'passed an empty AstNode' do
    it 'raises an ArgumentError' do
      expect { YardSequel::AstHash.new(Ast.s) }.to raise_error ArgumentError
    end
  end

  context 'passed an empty :hash AstNode' do
    it 'does not raise an Error' do
      expect { YardSequel::AstHash.new(Ast.s(:hash)) }.not_to raise_error
    end
  end

  context 'passed an empty :list AstNode' do
    it 'raises an ArgumentError' do
      expect { YardSequel::AstHash.new(Ast.s(:list)) }.to(
        raise_error ArgumentError
      )
    end
  end

  context 'passed a :list AstNode with :assoc children' do
    it 'does not raise an Error' do
      expect { YardSequel::AstHash.new(Ast.s(Ast.s(:assoc))) }.not_to(
        raise_error
      )
    end
  end
end

RSpec.describe YardSequel::AstHash, '#to_h' do
  context 'passed an empty Hash literal AST' do
    output_hash = YardSequel::AstHash.new(Ast.s(:hash)).to_h
    it 'returns a Hash' do
      expect(output_hash).to be_a Hash
    end

    it 'returns an empty Hash' do
      expect(output_hash).to be_empty
    end
  end
end
