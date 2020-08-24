class V1::InteractionsController < ApplicationController


  def create
    interaction = current_user.interactions.where(interaction_params).first
    if interaction.blank?
      result = Interaction.create(user_megred(interaction_params))
    else 
      result = interaction
      interaction.destroy
    end
    render json:  InteractionSerializer.new(result, source_type: params[:source_type], source_id: params[:source_id], user_id: current_user.id, scope: {user_id: current_user.id}).as_json, status: :ok
  end

  def destroy
    @interaction = Interaction.find(params[:id])
    if @interaction.destroy
      render json: { data: @interaction, klass: 'Interaction' }, status: :ok
    else
      render json: { data: @interaction.errors.full_messages  }, status: :ok
    end
  end

  def user_megred(params)
    params.merge({user_id: current_user.id})
  end 

  def interaction_params
    params.require(:interaction).permit!
  end

end
