class EventsController < ApplicationController
  def index
    @user = User.find(session[:user_id])
    @event = Event.new
    @local_events = Event.where("state =?", @user.state).order("date DESC")
    @other_events = Event.where("state !=?", @user.state).order("date DESC")
    @attending = @user.attending
  end

  def create
    @event = Event.new(event_params)
    @event.host_id = session[:user_id]
    if @event.save
      redirect_to events_path
    else
      flash[:notice] = @event.errors.full_messages
      redirect_to events_path
    end
  end

  def show
    @event = Event.find(params[:id])
    @comment = Comment.new
    @comments = Comment.where("event_id=?", @event.id).order("created_at DESC")
    @attendees = Attendee.where("event_id=?", @event.id)
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    @event.update(name: params[:name], date: params[:date], city: params[:city], state: params[:state])
    if @event.save
      flash[:notice] = ["Event has been updated succesfully."]
      redirect_to events_path
    else
      flash[:notice] = @event.errors.full_messages
      redirect_to :back
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to events_path
  end

  def join_event
    @event = Event.find(params[:id])
    @attending = Attendee.new(event_id: @event.id, user_id: session[:user_id])
    if @attending.save
      redirect_to events_path
    else
      flash[:notice] = @attending.errors.full_messages
      redirect_to events_path
    end
  end

  def unjoin_event
    @attending = Attendee.find_by("user_id =? AND event_id =?", session[:user_id], params[:id])
    @attending.destroy
    redirect_to events_path
  end

  protected
    def event_params
      params.require(:event).permit(:name, :date, :city, :state)
    end
end
