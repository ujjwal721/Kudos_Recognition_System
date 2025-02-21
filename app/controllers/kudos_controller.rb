class KudosController < ApplicationController
    before_action :authenticate_user!
  
    # GET /kudos/feed
    def feed
      # Combine sent and received kudos, order by created_at, then limit to 10.
      @kudos = Kudo.where("sender_id = ? OR receiver_id = ?", current_user.id, current_user.id)
                   .order(created_at: :desc)
                   .limit(10)
    end
  
    def new
      @kudo = Kudo.new
      # Eligible receivers: users with role >= current_user.role (excluding current_user)
      @eligible_receivers = User.where("role >= ?", current_user.role).where.not(id: current_user.id)
    end
  
    def create
      @kudo = current_user.kudos_sent.new(kudo_params)
      if @kudo.save
        # Enqueue background job for additional processing.
        SendKudoJob.perform_later(@kudo.id)
        redirect_to feed_kudos_path, notice: "Kudo sent successfully!"
      else
        flash.now[:alert] = @kudo.errors.full_messages.to_sentence
        render :new
      end
    end
  
    private
  
    def kudo_params
      params.require(:kudo).permit(:receiver_id, :message, :points)
    end
  end
  