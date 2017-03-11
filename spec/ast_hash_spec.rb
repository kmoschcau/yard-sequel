# frozen_string_literal: true
require 'yard'
require 'yard/parser/ruby/ast_node'

require_relative '../lib/yard-sequel/ast_node_hash'

class Ast
  extend YARD::Parser::Ruby
end

# rubocop:disable Metrics/BlockLength

RSpec.describe YardSequel::AstNodeHash, '.new' do
  context 'passed nil' do
    it 'raises a TypeError' do
      expect { YardSequel::AstNodeHash.new(nil) }.to raise_error TypeError
    end
  end

  context 'passed an empty AstNode' do
    it 'raises an ArgumentError' do
      expect { YardSequel::AstNodeHash.new(Ast.s) }.to raise_error ArgumentError
    end
  end

  context 'passed an empty :hash AstNode' do
    it 'does not raise an Error' do
      expect { YardSequel::AstNodeHash.new(Ast.s(:hash)) }.not_to raise_error
    end
  end

  context 'passed an empty :list AstNode' do
    it 'raises an ArgumentError' do
      expect do
        YardSequel::AstNodeHash.new(Ast.s(:list))
      end.to raise_error ArgumentError
    end
  end

  context 'passed a :list AstNode with :assoc children' do
    it 'does not raise an Error' do
      expect do
        YardSequel::AstNodeHash.new(Ast.s(Ast.s(:assoc, Ast.s, Ast.s)))
      end.not_to raise_error
    end
  end

  context 'passed an AstNode with an :assoc child with only one child' do
    it 'raises an ArgumentError' do
      expect do
        YardSequel::AstNodeHash.new(Ast.s(Ast.s(:assoc, Ast.s)))
      end.to raise_error ArgumentError
    end
  end

  context 'passed an AstNode with an :assoc child with three children' do
    it 'raises an ArgumentError' do
      expect do
        YardSequel::AstNodeHash.new(Ast.s(Ast.s(:assoc, Ast.s, Ast.s, Ast.s)))
      end.to raise_error ArgumentError
    end
  end
end

RSpec.describe YardSequel::AstNodeHash,
               '#to_h called on an AstHash initialized with' do
  context 'an empty :hash AST' do
    output_hash = YardSequel::AstNodeHash.new(Ast.s(:hash)).to_h

    it 'returns a Hash' do
      expect(output_hash).to be_a Hash
    end

    it 'returns an empty Hash' do
      expect(output_hash).to be_empty
    end
  end

  context 'a :hash AST with a single :assoc child' do
    ast         = Ast.s(:hash, Ast.s(:assoc, Ast.s, Ast.s))
    output_hash = YardSequel::AstNodeHash.new(ast).to_h

    it 'returns a Hash' do
      expect(output_hash).to be_a Hash
    end

    it 'returns a Hash with exactly one element' do
      expect(output_hash.size).to be 1
    end

    it 'returns a Hash with an AstNode as key and an AstNode as value' do
      expect(output_hash).to be(Ast.s => Ast.s)
    end
  end

  random_number = rand(20)
  context "a :hash AST with #{random_number} :assoc children" do
    # rubocop:disable Lint/UnneededSplatExpansion
    ast = Ast.s(:hash, *Array.new(random_number) do |number|
                         Ast.s(:assoc, Ast.s(number), Ast.s)
                       end)
    # rubocop:enable Lint/UnneededSplatExpansion
    output_hash = YardSequel::AstNodeHash.new(ast).to_h

    it 'returns a Hash' do
      expect(output_hash).to be_a Hash
    end

    it "returns a Hash with #{random_number} elements" do
      expect(output_hash.size).to be random_number
    end

    it "returns a Hash with #{random_number} AstNode key pairs" do
      match_hash = {}
      random_number.times { |number| match_hash[Ast.s(number)] = Ast.s }
      expect(output_hash).to be match_hash
    end
  end

  context 'a :list AST with a single :assoc child' do
    ast         = Ast.s(Ast.s(:assoc, Ast.s, Ast.s))
    output_hash = YardSequel::AstNodeHash.new(ast).to_h

    it 'returns a Hash' do
      expect(output_hash).to be_a Hash
    end

    it 'returns a Hash with exactly one element' do
      expect(output_hash.size).to be 1
    end

    it 'returns a Hash with an AstNode as key and an AstNode as value' do
      expect(output_hash).to be(Ast.s => Ast.s)
    end
  end

  random_number = rand(20)
  context "a :list AST with #{random_number} :assoc children" do
    # rubocop:disable Lint/UnneededSplatExpansion
    ast = Ast.s(*Array.new(random_number) do |number|
                  Ast.s(:assoc, Ast.s(number), Ast.s)
                end)
    # rubocop:enable Lint/UnneededSplatExpansion
    output_hash = YardSequel::AstNodeHash.new(ast).to_h

    it 'returns a Hash' do
      expect(output_hash).to be_a Hash
    end

    it "returns a Hash with #{random_number} elements" do
      expect(output_hash.size).to be random_number
    end

    it "returns a Hash with #{random_number} AstNode key pairs" do
      match_hash = {}
      random_number.times { |number| match_hash[Ast.s(number)] = Ast.s }
      expect(output_hash).to be match_hash
    end
  end
end
