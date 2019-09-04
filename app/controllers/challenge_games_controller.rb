class ChallengeGamesController < ApplicationController
  before_action :set_challenge_game, only: [:show, :edit, :update, :destroy]

  # GET /challenge_games
  # GET /challenge_games.json
  def index
    @challenge_games = ChallengeGame.all
  end

  # GET /challenge_games/1
  # GET /challenge_games/1.json
  def show
  end

  # GET /challenge_games/new
  def new
    @challenge_game = ChallengeGame.new
  end

  # GET /challenge_games/1/edit
  def edit
  end

  # POST /challenge_games
  # POST /challenge_games.json
  def create
    @challenge_game = ChallengeGame.new(challenge_game_params)

    respond_to do |format|
      if @challenge_game.save
        format.html { redirect_to @challenge_game, notice: 'Challenge game was successfully created.' }
        format.json { render :show, status: :created, location: @challenge_game }
      else
        format.html { render :new }
        format.json { render json: @challenge_game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /challenge_games/1
  # PATCH/PUT /challenge_games/1.json
  def update
    respond_to do |format|
      if @challenge_game.update(challenge_game_params)
        format.html { redirect_to @challenge_game, notice: 'Challenge game was successfully updated.' }
        format.json { render :show, status: :ok, location: @challenge_game }
      else
        format.html { render :edit }
        format.json { render json: @challenge_game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /challenge_games/1
  # DELETE /challenge_games/1.json
  def destroy
    @challenge_game.destroy
    respond_to do |format|
      format.html { redirect_to challenge_games_url, notice: 'Challenge game was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_challenge_game
      @challenge_game = ChallengeGame.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def challenge_game_params
      params.require(:challenge_game).permit(:game_id, :challenge_id)
    end
end
