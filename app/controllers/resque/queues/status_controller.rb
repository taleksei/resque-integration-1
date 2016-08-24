module Resque
  module Queues
    class StatusController < ActionController::Metal
      def show
        request = params.fetch('request')
        self.response_body =
          case request
          when 'age'
            age(params['queue'])
          when 'size'
            size(params['queue'])
          when 'threshold_size'
            Resque.queues_info.threshold_size(params.fetch('queue'))
          when 'threshold_age'
            Resque.queues_info.threshold_age(params.fetch('queue'))
          else
            0
          end.to_s
      end

      private

      def age(queue)
        queue ? Resque.queues_info.age_for_queue(queue) : Resque.queues_info.age_overall
      end

      def size(queue)
        queue ? Resque.queues_info.size_for_queue(queue) : Resque.queues_info.size_overall
      end
    end
  end
end
