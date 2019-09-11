class RoomUsersController < ApplicationController
  before_action :set_room_user, only: [:show, :edit, :update, :destroy]
  before_action :check_member_permissions, only: [:update, :destroy]
  access :user => :all

  def index
    @room_users = RoomUser.all
  end

  def show
  end

  def new
    @room_user = RoomUser.new
  end

  def edit
  end

  def create
    @room_user = RoomUser.new(room_user_params)

    respond_to do |format|
      if @room_user.save
        format.html { redirect_to @room_user, notice: 'Room user was successfully created.' }
        format.json { render :show, status: :created, location: @room_user }
      else
        format.html { render :new }
        format.json { render json: @room_user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @room_user.update(room_user_params)
        format.html { redirect_to @room_user, notice: 'Room user was successfully updated.' }
        format.json { render :show, status: :ok, location: @room_user }
      else
        format.html { render :edit }
        format.json { render json: @room_user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @room = @room_user.room
    if @room_user.room.room_users.count == 1
      @destroy_room = true
    end
    @room_user.destroy
    if @destroy_room == true
      @room.destroy 
    else
      @room.emit({'data_type':'user', 'message':'player_left', 'session_hash':current_user.session_hash, 'player_name':current_user.name})
      @room.messages.create(body: "#{current_user.name} has left.")
    end
    respond_to do |format|
      format.html { redirect_to rooms_path }
    end
  end

  private
  def set_room_user
    @room_user = RoomUser.find(params[:id])
  end

  def room_user_params
    params.require(:room_user).permit(:user_id, :room_id, :role)
  end
  
  def check_member_permissions
    forbidden! unless @room_user.user == current_user
  end
end
