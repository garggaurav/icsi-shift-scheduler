class UsersController < ApplicationController

  def user_params
    params.permit(:email, :username, :password, :password_confirmation,
                  :city, :state, :zip_code, :phone_number)
  end

  def join_shift
    @shift = Shift.find params[:id]

    unless @user.nil? or @shift.nil?
      VolunteerCommitment.create user: @user, shift: @shift
      flash[:notice] = 'You have been signed up for the shift'
      if @shift.has_limit and @shift.volunteer_commitments.length == @shift.limit
        UserActivity.create user_id: @shift.event.user.id, activity_id: UserActivity.shift_full_id, shift_id: @shift
      end
        
    end

    redirect_to event_shift_path @shift.event, @shift
  end

  def leave_shift
    @shift = Shift.find params[:id]
    @commitment = VolunteerCommitment.find_by user: @user, shift: @shift

    unless @commitment.nil?
      flash[:notice] = 'You have left the shift'
      @commitment.destroy
    end
    redirect_to event_shift_path @shift.event, @shift
  end

end