# frozen_string_literal: true

module YardSequel
  # Offers methods to convert an Abstract Syntax Tree of a Hash literal or named
  # method parameters to a Hash consisting of `YARD::Parser::Ruby::AstNode`s.
  # @author Kai Moschcau
  module AstNodeHash
    class << self
      # Creates a new Hash from the passed AstNode. This is the main method to
      # use, to create a new Hash.
      # @param (see .node_hash_from_node)
      # @raise (see .check_ast)
      # @return (see .node_hash_from_node)
      def from_ast(ast)
        check_ast ast
        node_hash_from_node ast
      end

      # Checks the passed AstNode for validity. If the AstNode is valid, this
      # method does not raise an error.
      # @raise [TypeError, ArgumentError] If the AstNode is not valid.
      # @param [YARD::Parser::Ruby::AstNode] ast The AstNode to check for
      #   validity.
      def check_ast(ast)
        check_is_ast_node ast
        check_is_hash_or_list ast
        case ast.type
        when :hash then check_hash_children ast
        when :list then check_list_children ast
        end
      end

      private

      # Checks if the given child AstNode has exactly two children.
      # @raise [ArgumentError] If if does not have 2 children.
      # @return [void]
      def check_assoc_child_has_two_children(child_ast)
        return if child_ast.children.size == 2

        raise(ArgumentError, 'each `:assoc` child must have two children')
      end

      # Checks the children of the given AstNode. Mainly it first checks, if the
      # AstNode has only `:assoc` type children and if each child has two
      # further children.
      # @return [void]
      def check_children(ast)
        check_has_only_assoc_children ast
        ast.children.each do |child_ast|
          check_assoc_child_has_two_children child_ast
        end
      end

      # Checks if the children of the passed AstNode are all of type `:assoc`.
      # @raise [ArgumentError] If there is at least one not of type `:assoc`.
      # @return [void]
      def check_has_only_assoc_children(ast)
        return unless ast.children.any? { |child| child.type != :assoc }

        raise(ArgumentError,
              'all children of the passed `ast` have to have the type `:assoc`')
      end

      # Checks the children of a `:hash` type AstNode. If the AstNode has no
      # children, this does nothing. Otherwise it runs {.check_children}.
      # @return [void]
      def check_hash_children(ast)
        return if ast.children.empty?

        check_children ast
      end

      # Checks, whether the passed Object is a `YARD::Parser::Ruby::AstNode`.
      # @raise [TypeError] If the passed Object is not of the correct type.
      # @return [void]
      def check_is_ast_node(ast)
        return if ast.is_a? YARD::Parser::Ruby::AstNode

        raise(TypeError,
              'the passed `ast` has to be a `YARD::Parser::Ruby::AstNode`')
      end

      # Checks, whether the passed AstNode is of Type `:hash` or `:list`.
      # @raise [ArgumentError] If the passed AstNode is not of the correct type.
      # @return [void]
      def check_is_hash_or_list(ast)
        return if %i[hash list].include? ast.type

        raise(ArgumentError,
              "the passed `ast`'s type has to be `:hash` or `:list`")
      end

      # Checks the children of a `:list` type AstNode. If the AstNode has no
      # children, this raises an error. Otherwise it runs {.check_children}.
      # @raise [ArgumentError] If the passed AstNode has no children.
      # @return [void]
      def check_list_children(ast)
        if ast.children.empty?
          raise(ArgumentError,
                'a passed `ast` of type `:list` has to have children')
        end
        check_children ast
      end

      # Converts the passed AstNode to a Hash.
      # @param [YARD::Parser::Ruby::AstNode] ast The AstNode to convert to a
      #   Hash.
      # @return [Hash<YARD::Parser::Ruby::AstNode>] the converted Hash.
      def node_hash_from_node(ast)
        hash = {}
        ast.children.each { |cn| hash[cn.children[0]] = cn.children[1] }
        hash
      end
    end
  end
end
