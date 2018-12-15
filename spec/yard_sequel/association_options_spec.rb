# frozen_string_literal: true

require 'yard'

RSpec.describe YardSequel::AssociationOptions do
  subject { described_class.new({}) }

  let(:ast_node) do
    YARD::Parser::Ruby::RipperParser.new(source, '').parse.ast
  end

  describe '#extract_symbol_content' do
    subject { super().send(:extract_symbol_content, ast_node) }

    context 'when passed a Symbol literal node' do
      let(:source) { ':foo' }

      it('is the Symbol content as a Symbol') { is_expected.to eq :foo }
    end

    context 'when passed a Hash label node' do
      let(:source) { '{foo: :bar}' }
      let(:ast_node) { super().jump(:label) }

      it('is the Symbol content as a Symbol') { is_expected.to eq :foo }
    end

    context 'when passed a dynamic Symbol literal node' do
      context 'with double quotes as delimiters' do
        let(:source) { ':"foo"' }

        it('is the Symbol content as a Symbol') { is_expected.to eq :foo }
      end

      context 'with single quotes as delimiters' do
        let(:source) { ":'foo'" }

        it('is the Symbol content as a Symbol') { is_expected.to eq :foo }
      end
    end
  end

  describe '#parse_symbol_node' do
    subject { super().send(:parse_symbol_node, ast_node) }

    let(:source) { 'Bar' }

    it('is the passed node') { is_expected.to be ast_node }

    context 'when passed a Symbol literal node' do
      let(:source) { ':foo' }
      let(:ast_node) { super().jump(:symbol_literal) }

      it('is the Symbol content as a Symbol') { is_expected.to eq :foo }
    end

    context 'when passed a Hash label node' do
      let(:source) { '{foo: :bar}' }
      let(:ast_node) { super().jump(:label) }

      it('is the Symbol content as a Symbol') { is_expected.to eq :foo }
    end

    context 'when passed a dynamic Symbol literal node' do
      let(:ast_node) { super().jump(:dyna_symbol) }

      context 'with double quotes as delimiters' do
        let(:source) { ':"foo"' }

        it('is the Symbol content as a Symbol') { is_expected.to eq :foo }
      end

      context 'with single quotes as delimiters' do
        context 'without interpolation' do
          let(:source) { ":'foo'" }

          it('is the Symbol content as a Symbol') { is_expected.to eq :foo }
        end

        context 'with interpolation' do
          # rubocop:disable Lint/InterpolationCheck
          let(:source) { ':"foo#{42}"' }
          # rubocop:enable Lint/InterpolationCheck

          it('is the passed node') { is_expected.to be ast_node }
        end
      end
    end
  end
end
