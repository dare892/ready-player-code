class RoomsController < ApplicationController
  before_action :set_room, only: [:show, :edit, :update, :destroy, :pin_enter]

  def index
    current_user.room_users.destroy_all
    @rooms = Room.all.order(created_at: :desc)
  end

  def show
    @room_user = @room.room_users.find_or_create_by(user: current_user)
  end

  # GET /rooms/new
  def new
    @room = Room.new
  end

  # GET /rooms/1/edit
  def edit
  end

  # POST /rooms
  # POST /rooms.json
  def create
    @room = Room.new(room_params)

    respond_to do |format|
      if @room.save
        format.html { redirect_to @room, notice: 'Room was successfully created.' }
        format.json { render :show, status: :created, location: @room }
      else
        format.html { render :new }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @room.update(room_params)
        case params[:action_type]
        when 'start_game'
          @room.games.find_or_create_by(status: 'playing')
          @room.emit({'data_type':'game_status', 'message':'start_game'})
          format.js { render json: nil, status: :ok }
        else
          format.html { redirect_to @room, notice: 'Room was successfully updated.' }
        end
      else
        format.html { render :edit }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @room.destroy
    respond_to do |format|
      format.html { redirect_to rooms_url, notice: 'Room was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def pin_enter
    if @room.pin != params[:pin]
      @alert = "Wrong Password"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_room
      @room = Room.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def room_params
      params.require(:room).permit(:name, :pin, :language_id, :mode, :difficulty, :status)
    end
end
