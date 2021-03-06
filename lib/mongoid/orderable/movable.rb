module Mongoid
  module Orderable
    module Movable

      def move_to!(target_position, options={})
        move_column_to target_position, options
        save
      end
      alias_method :insert_at!, :move_to!

      def move_to(target_position, options={})
        move_column_to target_position, options
      end
      alias_method :insert_at, :move_to

      def move_to=(target_position, options={})
        move_column_to target_position, options
      end
      alias_method :insert_at=, :move_to=

      [:top, :bottom].each do |symbol|
        class_eval <<-eos
          def move_to_#{symbol}(options = {})
            move_to :#{symbol}, options
          end

          def move_to_#{symbol}!(options = {})
            move_to! :#{symbol}, options
          end
        eos
      end

      [:higher, :lower].each do |symbol|
        class_eval <<-eos
          def move_#{symbol}(options = {})
            move_to :#{symbol}, options
          end

          def move_#{symbol}!(options = {})
            move_to! :#{symbol}, options
          end
        eos
      end

      protected

      def move_all
        @move_all || {}
      end

      def move_column_to(position, options)
        column = options[:column] || default_orderable_column
        @move_all = move_all.merge(column => position)
      end

    end
  end
end
