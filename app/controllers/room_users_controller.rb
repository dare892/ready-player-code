class RoomUsersController < ApplicationController
  before_action :set_room_user, only: [:show, :edit, :update, :destroy]

  # GET /room_users
  # GET /room_users.json
  def index
    @room_users = RoomUser.all
  end

  # GET /room_users/1
  # GET /room_users/1.json
  def show
  end

  # GET /room_users/new
  def new
    @room_user = RoomUser.new
  end

  # GET /room_users/1/edit
  def edit
  end

  # POST /room_users
  # POST /room_users.json
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

  # PATCH/PUT /room_users/1
  # PATCH/PUT /room_users/1.json
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
    # Use callbacks to share common setup or constraints between actions.
    def set_room_user
      @room_user = RoomUser.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def room_user_params
      params.require(:room_user).permit(:user_id, :room_id, :role)
    end
end
