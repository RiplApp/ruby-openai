module OpenAI
  class FineTuning
    def initialize(client:)
      @client = client
    end

    def list
      @client.get(path: "/fine_tuning/jobs")
    end

    def create(parameters: {})
      @client.json_post(path: "/fine_tuning/jobs", parameters: parameters)
    end

    def retrieve(id:)
      @client.get(path: "/fine_tuning/jobs/#{id}")
    end

    def cancel(id:)
      @client.multipart_post(path: "/fine_tuning/jobs/#{id}/cancel")
    end

    def events(id:)
      @client.get(path: "/fine_tuning/jobs/#{id}/events")
    end

    def delete(fine_tuned_model:)
      if fine_tuned_model.start_with?("ft-")
        raise ArgumentError, "Please give a fine_tuned_model name, not a fine-tune ID"
      end

      @client.delete(path: "/models/#{fine_tuned_model}")
    end
  end
end
