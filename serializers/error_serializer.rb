class ErrorSerializer < BaseSerializer

  def self.serialized_model_errors(model, status)
    model_errors = model.errors.messages.map do |field, errors|
      errors.map do |error_message|
        {
          errors: [
            {
              status: status.to_s,
              source: { pointer: "data/attributes/#{field}" },
              title: field,
              detail: error_message
            }
          ]
        }
      end
    end
    model_errors.flatten
  end

  def self.custom_error(status, source, title, detail)
    {
      errors: [
        {
          status: status.to_s,
          source: { pointer: "data/model/#{source}" },
          title: title,
          detail: detail
        }
      ]
    }
  end
end
