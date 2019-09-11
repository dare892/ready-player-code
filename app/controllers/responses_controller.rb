class ResponsesController < ApplicationController
  before_action :set_response, only: [:show, :edit, :update, :destroy]
  access :user => :all

  def index
    @responses = Response.all
  end

  def show
  end

  def new
    @response = Response.new
  end

  def edit
  end

  def create
    @response = Response.new(response_params.merge(user: current_user))
    @result = @response.challenge_game.challenge.check_answer(response_params[:body])
    @game = @response.challenge_game.game

    respond_to do |format|
      if @result == 'pass'
        if @response.save
          if @game.completed_all_challenges(current_user)
            @response.room.emit({'data_type':'in_game', 'message':'completed_game', 'game_id':@game.id})
            @response.room.update(status: 'pending')
            @game.win(current_user)
            msg = @response.room.messages.create(body: "#{current_user.name} has won the game!")
            format.js { render json: nil, status: :ok }
          else
            current_user.earn_points('challenge')
            @response.room.emit({'data_type':'in_game', 'message':'completed_challenge', 'session_hash':current_user.session_hash, 'player_name':current_user.name})
            format.js { render "responses/success.js.erb"}
          end
        else
          format.js { render "shared/failed.js.erb"}
        end
      else
        format.js { render "responses/failed.js.erb"}
        # need to respond here with what is wrong
      end
    end
  end

  def update
    respond_to do |format|
      if @response.update(response_params)
        format.html { redirect_to @response, notice: 'Response was successfully updated.' }
        format.json { render :show, status: :ok, location: @response }
      else
        format.html { render :edit }
        format.json { render json: @response.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @response.destroy
    respond_to do |format|
      format.html { redirect_to responses_url, notice: 'Response was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_response
      @response = Response.find(params[:id])
    end

    def response_params
      params.require(:response).permit(:challenge_game_id, :user_id, :body)
    end
end
