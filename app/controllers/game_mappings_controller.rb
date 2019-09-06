class GameMappingsController < ApplicationController
  before_action :set_game_mapping, only: [:show, :edit, :update, :destroy]

  # GET /game_mappings
  # GET /game_mappings.json
  def index
    @game_mappings = GameMapping.all
  end

  # GET /game_mappings/1
  # GET /game_mappings/1.json
  def show
  end

  # GET /game_mappings/new
  def new
    @game_mapping = GameMapping.new
  end

  # GET /game_mappings/1/edit
  def edit
  end

  # POST /game_mappings
  # POST /game_mappings.json
  def create
    @game_mapping = GameMapping.new(game_mapping_params)

    respond_to do |format|
      if @game_mapping.save
        format.html { redirect_to @game_mapping, notice: 'Game mapping was successfully created.' }
        format.json { render :show, status: :created, location: @game_mapping }
      else
        format.html { render :new }
        format.json { render json: @game_mapping.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /game_mappings/1
  # PATCH/PUT /game_mappings/1.json
  def update
    respond_to do |format|
      if @game_mapping.update(game_mapping_params)
        format.html { redirect_to @game_mapping, notice: 'Game mapping was successfully updated.' }
        format.json { render :show, status: :ok, location: @game_mapping }
      else
        format.html { render :edit }
        format.json { render json: @game_mapping.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /game_mappings/1
  # DELETE /game_mappings/1.json
  def destroy
    @game_mapping.destroy
    respond_to do |format|
      format.html { redirect_to game_mappings_url, notice: 'Game mapping was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game_mapping
      @game_mapping = GameMapping.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def game_mapping_params
      params.require(:game_mapping).permit(:game_mapping_group_id, :challenge_id, :sort)
    end
end
