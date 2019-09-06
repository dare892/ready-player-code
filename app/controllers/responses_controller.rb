class ResponsesController < ApplicationController
  before_action :set_response, only: [:show, :edit, :update, :destroy]

  # GET /responses
  # GET /responses.json
  def index
    @responses = Response.all
  end

  # GET /responses/1
  # GET /responses/1.json
  def show
  end

  # GET /responses/new
  def new
    @response = Response.new
  end

  # GET /responses/1/edit
  def edit
  end

  # POST /responses
  # POST /responses.json
  def create
    @response = Response.new(response_params)
    # handle docker processing here
    @result = 'pass'
    
    respond_to do |format|
      if @response.save
        if @result == 'pass'
          if @response.challenge_game.game.completed_all_challenges(current_user)
            # emit to all
            format.js { render "games/completed.js.erb"}
          else
            @response.room.emit({'data_type':'in_game', 'message':'completed_challenge', 'session_hash':current_user.session_hash})
            # emit to all
            format.js { render "responses/success.js.erb"}
          end
        else
          format.js { render "responses/failed.js.erb"}
        end
      else
        format.js { render "shared/failed.js.erb"}
      end
    end
      
  end

  # PATCH/PUT /responses/1
  # PATCH/PUT /responses/1.json
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

  # DELETE /responses/1
  # DELETE /responses/1.json
  def destroy
    @response.destroy
    respond_to do |format|
      format.html { redirect_to responses_url, notice: 'Response was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_response
      @response = Response.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def response_params
      params.require(:response).permit(:challenge_game_id, :user_id, :body)
    end
end
