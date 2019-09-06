class RoomsController < ApplicationController
  before_action :set_room, only: [:show, :edit, :update, :destroy, :pin_enter]

  def index
    current_user.room_users.destroy_all
    @rooms = Room.all.order(created_at: :desc)
  end

  def show
    if @room.status == 'pending'
      @room_user = @room.room_users.find_by(user: current_user)
      if !@room_user
        @room_user = @room.room_users.create(user: current_user)
        @room.messages.create(body: "#{current_user.name} has joined.")
        @room.emit({'data_type':'user', 'message':'player_joined', 'session_hash':current_user.session_hash})
      end
    else
      @room_user = @room.room_users.find_by(user: current_user)
      if !@room_user
        redirect_to rooms_path, alert: 'That room is already in a game.'
      end
    end
  end

  def new
    @room = Room.new
  end

  def edit
  end

  def create
    @room = Room.new(room_params.merge(status: 'pending'))

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
          @game = @room.games.create(status: 'playing')
          @game.setup
          @room.emit({'data_type':'game_status', 'message':'start_game', 'game_id': @game.id})
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
  
  def load_other_player
    respond_to do |format|
      @player = User.find_by(session_hash: params[:session_hash])
      format.js { render "rooms/show/load_other_player"}
    end
  end

  private
    def set_room
      @room = Room.find(params[:id])
    end

    def room_params
      params.require(:room).permit(:name, :pin, :language_id, :mode, :difficulty, :status)
    end
end
