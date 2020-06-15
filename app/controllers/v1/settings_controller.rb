class V1::SettingsController < ApplicationController

  def index
    settings = Setting.all
    render json: { data: ActiveModel::SerializableResource.new(settings, user_id: current_user.id,  each_serializer: SettingSerializer ).as_json, klass: 'Setting' }, status: :ok
  end


  def show
    @setting = Setting.find(params[:id])
    render json: { data:  SettingSerializer.new(@setting, user_id: current_user.id).as_json, klass: 'Setting'}, status: :ok
  end


  def create
    @setting = Setting.new(setting_params)
    @setting.user_id = current_user.id
    if @setting.save
      render json: { data: SettingSerializer.new(@setting).as_json, klass: 'Setting' }, status: :ok
    end
  end

  def update
    @setting = Setting.find(params[:id])
    if @setting.update_attributes(setting_params)
      render json: { data: SettingSerializer.new(@setting, user_id: current_user.id).as_json, klass: 'Setting' }, status: :ok
    else
      render json: { data: @setting.errors.full_messages  }, status: :ok
    end
  end

  def destroy
    @setting = Setting.find(params[:id])
    if @setting.destroy
      render json: { data: 'OK'}, status: :ok
    end
  end

  def setting_params
    params.require(:setting).permit!
  end
end
