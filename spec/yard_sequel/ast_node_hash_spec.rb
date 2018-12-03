# frozen_string_literal: true

require 'yard'
require 'yard/parser/ruby/ast_node'

# Helper class to easily create ASTs.
class Ast
  extend YARD::Parser::Ruby
end

RSpec.describe YardSequel::AstNodeHash do
  describe '.check_ast' do
    subject(:call) { described_class.check_ast(param) }

    context 'when passed nil' do
      let(:param) { nil }

      it('raises a TypeError') { expect { call }.to raise_error TypeError }
    end

    context 'when passed an empty AstNode' do
      let(:param) { Ast.s }

      it 'raises an ArgumentError' do
        expect { call }.to raise_error ArgumentError
      end
    end

    context 'when passed an empty :hash AstNode' do
      let(:param) { Ast.s(:hash) }

      it('does not raise an Error') { expect { call }.not_to raise_error }
    end

    context 'when passed an empty :list AstNode' do
      let(:param) { Ast.s(:list) }

      it 'raises an ArgumentError' do
        expect { call }.to raise_error ArgumentError
      end
    end

    context 'when passed a :list AstNode with :assoc children' do
      let(:param) { Ast.s(Ast.s(:assoc, Ast.s, Ast.s)) }

      it('does not raise an Error') { expect { call }.not_to raise_error }
    end

    context 'when passed an AstNode with an :assoc child with only one child' do
      let(:param) { Ast.s(Ast.s(:assoc, Ast.s)) }

      it 'raises an ArgumentError' do
        expect { call }.to raise_error ArgumentError
      end
    end

    context 'when passed an AstNode with an :assoc child with three children' do
      let(:param) { Ast.s(Ast.s(:assoc, Ast.s, Ast.s, Ast.s)) }

      it 'raises an ArgumentError' do
        expect { call }.to raise_error ArgumentError
      end
    end
  end

  describe '.from_ast' do
    subject(:result) { described_class.from_ast(param) }

    context 'when passed an empty :hash AST' do
      let(:param) { Ast.s(:hash) }

      it('returns a Hash') { is_expected.to be_a Hash }

      it('returns an empty Hash') { is_expected.to be_empty }
    end

    context 'when passed a :hash AST with a single :assoc child' do
      let(:param) { Ast.s(:hash, Ast.s(:assoc, Ast.s, Ast.s)) }

      it('returns a Hash') { is_expected.to be_a Hash }

      it 'returns a Hash with exactly one element' do
        expect(result.size).to be 1
      end

      it 'returns a Hash with an AstNode as key and an AstNode as value' do
        is_expected.to eq(Ast.s => Ast.s)
      end
    end

    context 'when passed a :hash AST with 10 :assoc children' do
      let(:param) do
        Ast.s(:hash, *Array.new(10) do |number|
          Ast.s(:assoc, Ast.s(number), Ast.s)
        end)
      end

      it('returns a Hash') { is_expected.to be_a Hash }

      it('returns a Hash with 10 elements') { expect(result.size).to be 10 }

      it 'returns a Hash with 10 AstNode key pairs' do
        is_expected.to eq n_elements_node_hash(10)
      end
    end

    context 'when passed a :list AST with a single :assoc child' do
      let(:param) { Ast.s(Ast.s(:assoc, Ast.s, Ast.s)) }

      it('returns a Hash') { is_expected.to be_a Hash }

      it 'returns a Hash with exactly one element' do
        expect(result.size).to be 1
      end

      it 'returns a Hash with an AstNode as key and an AstNode as value' do
        is_expected.to eq(Ast.s => Ast.s)
      end
    end

    context 'when passed a :list AST with 10 :assoc children' do
      let(:param) do
        Ast.s(*Array.new(10) do |number|
          Ast.s(:assoc, Ast.s(number), Ast.s)
        end)
      end

      it('returns a Hash') { is_expected.to be_a Hash }

      it 'returns a Hash with 10 elements' do
        expect(result.size).to be 10
      end

      it 'returns a Hash with 10 AstNode key pairs' do
        is_expected.to eq n_elements_node_hash(10)
      end
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
