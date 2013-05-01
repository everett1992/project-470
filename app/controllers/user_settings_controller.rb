class UserSettingsController < ApplicationController
	before_filter :is_self?
	#layout 'user_settings'

	def edit_profile
		@user = User.find(params[:id])
	end

	def update_profile
		@user = User.find(params[:id])
		if @user.update_attributes(params[:user])
			redirect_to profile_settings_user_path, notice: 'User profile was successfully updated.'
		else
			render :edit_profile
		end
	end

	def edit_account
		@user = User.find(params[:id])
	end

	def update_account
		@user = User.find(params[:id])
		if @user.update_attributes(params[:user])
			redirect_to account_settings_user_path, notice: 'User account was successfully updated.'
		else
			render :edit_account
		end
	end

	def edit_notifications
		@user = User.find(params[:id])
		@subscriptions = @user.subscriptions
	end

	def update_notifications
		@user = User.find(params[:id])
		begin
			if params[:unsubscribe]
				@user.dwelling.topic.subscriptions[params[:arn]].unsubscribe()
				redirect_to notifications_settings_user_path, notice: "Successfuly unsubscribed from #{params[:endpoint]}"
			else
				@user.dwelling.topic.subscribe(params[:endpoint])
				redirect_to notifications_settings_user_path, notice: "Confirmations sent to #{params[:endpoint]}"
			end
		rescue ArgumentError => error
			@subscriptions = @user.subscriptions
			flash[:alert] = error.message
			render :edit_notifications
		end
	end

  private

    def is_self?
      unless current_user && current_user.id == params[:id].to_i
        permission_denied
      end
    end
end
