# frozen_string_literal: true

require 'yard'
require 'yard/parser/ruby/ast_node'

require_relative '../lib/yard-sequel/ast_node_hash'

# Helper class to easily create ASTs.
class Ast
  extend YARD::Parser::Ruby
end

# rubocop:disable Metrics/BlockLength

RSpec.describe YardSequel::AstNodeHash, '.check_ast passed' do
  context 'nil' do
    it 'raises a TypeError' do
      expect { YardSequel::AstNodeHash.check_ast(nil) }.to raise_error TypeError
    end
  end

  context 'an empty AstNode' do
    it 'raises an ArgumentError' do
      expect { YardSequel::AstNodeHash.check_ast(Ast.s) }
        .to raise_error ArgumentError
    end
  end

  context 'an empty :hash AstNode' do
    it 'does not raise an Error' do
      expect { YardSequel::AstNodeHash.check_ast(Ast.s(:hash)) }
        .not_to raise_error
    end
  end

  context 'an empty :list AstNode' do
    it 'raises an ArgumentError' do
      expect { YardSequel::AstNodeHash.check_ast(Ast.s(:list)) }
        .to raise_error ArgumentError
    end
  end

  context 'a :list AstNode with :assoc children' do
    it 'does not raise an Error' do
      expect do
        YardSequel::AstNodeHash.check_ast(Ast.s(Ast.s(:assoc, Ast.s, Ast.s)))
      end.not_to raise_error
    end
  end

  context 'an AstNode with an :assoc child with only one child' do
    it 'raises an ArgumentError' do
      expect { YardSequel::AstNodeHash.check_ast(Ast.s(Ast.s(:assoc, Ast.s))) }
        .to raise_error ArgumentError
    end
  end

  context 'an AstNode with an :assoc child with three children' do
    it 'raises an ArgumentError' do
      expect do
        YardSequel::AstNodeHash
          .check_ast(Ast.s(Ast.s(:assoc, Ast.s, Ast.s, Ast.s)))
      end.to raise_error ArgumentError
    end
  end
end

RSpec.describe YardSequel::AstNodeHash, '.from_ast passed' do
  context 'an empty :hash AST' do
    output_hash = YardSequel::AstNodeHash.from_ast(Ast.s(:hash))

    it 'returns a Hash' do
      expect(output_hash).to be_a Hash
    end

    it 'returns an empty Hash' do
      expect(output_hash).to be_empty
    end
  end

  context 'a :hash AST with a single :assoc child' do
    ast         = Ast.s(:hash, Ast.s(:assoc, Ast.s, Ast.s))
    output_hash = YardSequel::AstNodeHash.from_ast(ast)

    it 'returns a Hash' do
      expect(output_hash).to be_a Hash
    end

    it 'returns a Hash with exactly one element' do
      expect(output_hash.size).to be 1
    end

    it 'returns a Hash with an AstNode as key and an AstNode as value' do
      expect(output_hash).to eq(Ast.s => Ast.s)
    end
  end

  hash_random_number = rand(20)
  context "a :hash AST with #{hash_random_number} :assoc children" do
    # rubocop:disable Lint/UnneededSplatExpansion
    ast = Ast.s(:hash, *Array.new(hash_random_number) do |number|
                         Ast.s(:assoc, Ast.s(number), Ast.s)
                       end)
    # rubocop:enable Lint/UnneededSplatExpansion
    output_hash = YardSequel::AstNodeHash.from_ast(ast)

    it 'returns a Hash' do
      expect(output_hash).to be_a Hash
    end

    it "returns a Hash with #{hash_random_number} elements" do
      expect(output_hash.size).to be hash_random_number
    end

    it "returns a Hash with #{hash_random_number} AstNode key pairs" do
      expect(output_hash).to eq n_elements_node_hash(hash_random_number)
    end
  end

  context 'a :list AST with a single :assoc child' do
    ast         = Ast.s(Ast.s(:assoc, Ast.s, Ast.s))
    output_hash = YardSequel::AstNodeHash.from_ast(ast)

    it 'returns a Hash' do
      expect(output_hash).to be_a Hash
    end

    it 'returns a Hash with exactly one element' do
      expect(output_hash.size).to be 1
    end

    it 'returns a Hash with an AstNode as key and an AstNode as value' do
      expect(output_hash).to eq(Ast.s => Ast.s)
    end
  end

  list_random_number = rand(20)
  context "a :list AST with #{list_random_number} :assoc children" do
    # rubocop:disable Lint/UnneededSplatExpansion
    ast = Ast.s(*Array.new(list_random_number) do |number|
                  Ast.s(:assoc, Ast.s(number), Ast.s)
                end)
    # rubocop:enable Lint/UnneededSplatExpansion
    output_hash = YardSequel::AstNodeHash.from_ast(ast)

    it 'returns a Hash' do
      expect(output_hash).to be_a Hash
    end

    it "returns a Hash with #{list_random_number} elements" do
      expect(output_hash.size).to be list_random_number
    end

    it "returns a Hash with #{list_random_number} AstNode key pairs" do
      expect(output_hash).to eq n_elements_node_hash(list_random_number)
    end
  end
end

# @param [Integer] number_elements The amount of elements the Hash should have.
# @return [Hash{YARD::Parser::Ruby::AstNode=>YARD::Parser::Ruby::AstNode}]
#   a Hash with the passed amount of AstNode key-value pairs.
def n_elements_node_hash(number_elements)
  hash = {}
  number_elements.times { |number| hash[Ast.s(number)] = Ast.s }
  hash
end
