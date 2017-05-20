# frozen_string_literal: true

module YardSequel
  # Offers methods to convert an Abstract Syntax Tree to a Hash consisting
  # of `YARD::Parser::Ruby::AstNode`s.
  # @author Kai Moschcau
  module AstNodeHash
    class << self
      def from_ast(ast)
        check_ast ast
        node_hash_from_node ast
      end

      def check_ast(ast)
        check_is_ast_node ast
        check_is_hash_or_list ast
        case ast.type
        when :hash then check_hash_children ast
        when :list then check_list_children ast
        end
      end

      private

      def check_assoc_child_has_two_children(child_ast)
        return if child_ast.children.size == 2
        raise(ArgumentError, 'each `:assoc` child must have two children')
      end

      def check_children(ast)
        check_has_only_assoc_children ast
        ast.children.each do |child_ast|
          check_assoc_child_has_two_children child_ast
        end
      end

      def check_has_only_assoc_children(ast)
        return unless ast.children.any? { |child| child.type != :assoc }
        raise(ArgumentError,
              'all children of the passed `ast` have to have the type `:assoc`')
      end

      def check_hash_children(ast)
        return if ast.children.empty?
        check_children ast
      end

      def check_is_ast_node(ast)
        return if ast.is_a? YARD::Parser::Ruby::AstNode
        raise(TypeError,
              'the passed `ast` has to be a `YARD::Parser::Ruby::AstNode`')
      end

      def check_is_hash_or_list(ast)
        return if %i[hash list].include? ast.type
        raise(ArgumentError,
              "the passed `ast`'s type has to be `:hash` or `:list`")
      end

      def check_list_children(ast)
        if ast.children.empty?
          raise(ArgumentError,
                'a passed `ast` of type `:list` has to have children')
        end
        check_children ast
      end

      def node_hash_from_node(ast)
        hash = {}
        ast.children.each { |cn| hash[cn.children[0]] = cn.children[1] }
        hash
      end
    end
  end
end
