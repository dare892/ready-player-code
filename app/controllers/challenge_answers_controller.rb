class ChallengeAnswersController < ApplicationController
  before_action :set_challenge_answer, only: [:show, :edit, :update, :destroy]

  def index
    @challenge_answers = ChallengeAnswer.all
  end

  def show
  end

  def new
    @challenge_answer = ChallengeAnswer.new
  end

  def edit
  end

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

  def destroy
    @challenge = @challenge_answer.challenge
    @challenge_answer.destroy
    respond_to do |format|
      format.html { redirect_to challenge_path(@challenge), notice: 'Challenge answer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_challenge_answer
      @challenge_answer = ChallengeAnswer.find(params[:id])
    end

    def challenge_answer_params
      params.require(:challenge_answer).permit(:challenge_id, :input, :output)
    end
end
