class ErrorSerializer < BaseSerializer

  def self.serialized_error(status:, model: nil, source: nil, details: nil)
    return serialized_hash(status, source, details) if model.nil?

    source, details = extract_attributes(model)

    serialized_hash(status, source, details)
  end

  private_class_method def self.extract_attributes(model)
    attributes = []
    model.errors.messages.map do |field, errors|
      attributes << field
      errors.map do |error_message|
        attributes << error_message
      end
    end
    attributes
  end

  private_class_method def self.serialized_hash(status, source, details)
    {
      errors: [
        {
          status: status.to_s,
          source: { pointer: "data/model/#{source}" },
          title: source.to_s,
          details: details
        }
      ]
    }
  end
end
