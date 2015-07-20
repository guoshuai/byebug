module Byebug
  #
  # Reopens the +info+ command to define the +display+ subcommand
  #
  class InfoCommand < Command
    #
    # Information about display expressions
    #
    class DisplaySubcommand < Command
      self.allow_in_post_mortem = true

      def regexp
        /^\s* d(?:isplay)? \s*$/x
      end

      def description
        <<-EOD
          inf[o] d[display]

          #{short_description}
        EOD
      end

      def short_description
        'List of expressions to display when program stops'
      end

      def execute
        unless @state.display.find { |d| d[0] }
          return puts('There are no auto-display expressions now.')
        end

        puts 'Auto-display expressions now in effect:'
        puts 'Num Enb Expression'

        @state.display.each_with_index do |d, i|
          puts(format('%3d: %s  %s', i + 1, d[0] ? 'y' : 'n', d[1]))
        end
      end
    end
  end
end
