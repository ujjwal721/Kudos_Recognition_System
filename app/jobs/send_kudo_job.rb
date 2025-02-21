class SendKudoJob < ApplicationJob
  queue_as :default

  def perform(kudo_id)
    kudo = Kudo.find_by(id: kudo_id)
    return unless kudo

    Rails.logger.info "Processing Kudo ID: #{kudo.id} from #{kudo.sender.name} to #{kudo.receiver.name}"
    # Add additional asynchronous processing if needed.
  end
end
