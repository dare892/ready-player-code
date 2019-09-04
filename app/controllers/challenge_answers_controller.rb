class ChallengeAnswersController < ApplicationController
  before_action :set_challenge_answer, only: [:show, :edit, :update, :destroy]

  # GET /challenge_answers
  # GET /challenge_answers.json
  def index
    @challenge_answers = ChallengeAnswer.all
  end

  # GET /challenge_answers/1
  # GET /challenge_answers/1.json
  def show
  end

  # GET /challenge_answers/new
  def new
    @challenge_answer = ChallengeAnswer.new
  end

  # GET /challenge_answers/1/edit
  def edit
  end

  # POST /challenge_answers
  # POST /challenge_answers.json
  def create
    @challenge_answer = ChallengeAnswer.new(challenge_answer_params)

    respond_to do |format|
      if @challenge_answer.save
        format.html { redirect_to @challenge_answer, notice: 'Challenge answer was successfully created.' }
        format.json { render :show, status: :created, location: @challenge_answer }
      else
        format.html { render :new }
        format.json { render json: @challenge_answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /challenge_answers/1
  # PATCH/PUT /challenge_answers/1.json
  def update
    respond_to do |format|
      if @challenge_answer.update(challenge_answer_params)
        format.html { redirect_to @challenge_answer, notice: 'Challenge answer was successfully updated.' }
        format.json { render :show, status: :ok, location: @challenge_answer }
      else
        format.html { render :edit }
        format.json { render json: @challenge_answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /challenge_answers/1
  # DELETE /challenge_answers/1.json
  def destroy
    @challenge_answer.destroy
    respond_to do |format|
      format.html { redirect_to challenge_answers_url, notice: 'Challenge answer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_challenge_answer
      @challenge_answer = ChallengeAnswer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def challenge_answer_params
      params.require(:challenge_answer).permit(:challenge_id, :input, :output)
    end
end
