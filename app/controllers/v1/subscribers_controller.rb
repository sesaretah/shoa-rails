class V1::SubscribersController < ApplicationController

  def create
    @subscriber = Subscriber.new(subscriber_params)
    @subscriber.user_id = current_user.id
    if @subscriber.save
      render json: { data: SubscriberSerializer.new(@subscriber).as_json, klass: 'Subscriber' }, status: :ok
    end
  end

  def update
    @subscriber = Subscriber.find(params[:id])
    if @subscriber.update_attributes(subscriber_params)
      render json: { data: SubscriberSerializer.new(@subscriber, user_id: current_user.id).as_json, klass: 'Subscriber' }, status: :ok
    else
      render json: { data: @subscriber.errors.full_messages  }, status: :ok
    end
  end

  def destroy
    @subscriber = Subscriber.find(params[:id])
    if @subscriber.destroy
      render json: { data: 'OK'}, status: :ok
    end
  end

  def subscriber_params
    params.require(:subscriber).permit!
  end
end
