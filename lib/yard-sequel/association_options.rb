# frozen_string_literal: true

module YardSequel
  # Holds the options of an association macro call and makes them easily
  # accessible.
  # @author Kai Moschcau
  class AssociationOptions
    # @param [Hash<Yard::Parser::Ruby::AstNode>] ast_node_hash A Hash created
    #   with the {AstNodeHash} module, to get the options from.
    def initialize(ast_node_hash)
      @ast_node_hash = {}
      ast_node_hash.each do |name, parameter|
        @ast_node_hash[parse_symbol_node name] = parse_symbol_node parameter
      end
    end

    # @param [Symbol] option_name The name of the option, to get the parameter
    #   of.
    # @return [Yard::Parser::Ruby::AstNode] the option parameter value.
    def [](option_name)
      @ast_node_hash[option_name]
    end

    private

    # Extracts the String content of a Symbol literal AstNode as a Symbol. It
    # gets the source, then removes the leading or trailing colon. Afterwards it
    # removes the leading and trailing quotes, if there are any and returns the
    # result as a Symbol.
    # @param [Yard::Parser::Ruby::AstNode] ast_node The Symbol literal AstNode
    #   to get the content from.
    # @return [Symbol] the Symbol literal's content as a Symbol.
    def extract_symbol_content(ast_node)
      ast_node.source.gsub(/(?:^:|:$)/, '').gsub(/(?:^['"]|['"]$)/, '').to_sym
    end

    # Parses a Symbol literal AstNode, if possible. This will return a Symbol
    # with the Symbol literal's content String, if the literal is a Hash label,
    # a normal Symbol literal or a dynamic Symbol literal without interpolation.
    # @param [Yard::Parser::Ruby::AstNode] symbol_node The AstNode to get the
    #   content String from.
    # @return [Symbol] the parsed Symbol.
    # @return [Yard::Parser::Ruby::AstNode] the passed node, if it could not be
    #   parsed.
    def parse_symbol_node(symbol_node)
      if %i[symbol_literal label dyna_symbol].include? symbol_node.type
        # Return if the literal contains interpolation
        return symbol_node if symbol_node.jump(:string_embexpr) != symbol_node

        return extract_symbol_content(symbol_node)
      end

      symbol_node
    end
  end
end
