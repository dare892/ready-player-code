class GameMappingGroupsController < ApplicationController
  before_action :set_game_mapping_group, only: [:show, :edit, :update, :destroy]

  # GET /game_mapping_groups
  # GET /game_mapping_groups.json
  def index
    @game_mapping_groups = GameMappingGroup.all
  end

  # GET /game_mapping_groups/1
  # GET /game_mapping_groups/1.json
  def show
  end

  # GET /game_mapping_groups/new
  def new
    @game_mapping_group = GameMappingGroup.new
  end

  # GET /game_mapping_groups/1/edit
  def edit
  end

  # POST /game_mapping_groups
  # POST /game_mapping_groups.json
  def create
    @game_mapping_group = GameMappingGroup.new(game_mapping_group_params)

    respond_to do |format|
      if @game_mapping_group.save
        format.html { redirect_to @game_mapping_group, notice: 'Game mapping group was successfully created.' }
        format.json { render :show, status: :created, location: @game_mapping_group }
      else
        format.html { render :new }
        format.json { render json: @game_mapping_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /game_mapping_groups/1
  # PATCH/PUT /game_mapping_groups/1.json
  def update
    respond_to do |format|
      if @game_mapping_group.update(game_mapping_group_params)
        format.html { redirect_to @game_mapping_group, notice: 'Game mapping group was successfully updated.' }
        format.json { render :show, status: :ok, location: @game_mapping_group }
      else
        format.html { render :edit }
        format.json { render json: @game_mapping_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /game_mapping_groups/1
  # DELETE /game_mapping_groups/1.json
  def destroy
    @game_mapping_group.destroy
    respond_to do |format|
      format.html { redirect_to game_mapping_groups_url, notice: 'Game mapping group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game_mapping_group
      @game_mapping_group = GameMappingGroup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def game_mapping_group_params
      params.require(:game_mapping_group).permit(:difficulty, :language_id)
    end
end
