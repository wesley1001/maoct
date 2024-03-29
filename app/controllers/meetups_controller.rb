class MeetupsController < ApplicationController
  before_action :set_meetup, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /meetups
  # GET /meetups.json
  def index
    @meetups = Meetup.all
  end

  # GET /meetups/1
  # GET /meetups/1.json
  def show
    @enrolled = current_user.meetup_ids.include?(@meetup.id)
  end

  # GET /meetups/new
  def new
    @meetup = Meetup.new
  end

  # GET /meetups/1/edit
  def edit
  end

  # POST /meetups
  # POST /meetups.json
  def create
    @meetup = Meetup.new(meetup_params)
    @meetup.author = current_user

    respond_to do |format|
      if @meetup.save
        format.html { redirect_to @meetup, notice: 'Meetup was successfully created.' }
        format.json { render :show, status: :created, location: @meetup }
      else
        format.html { render :new }
        format.json { render json: @meetup.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /meetups/1
  # PATCH/PUT /meetups/1.json
  def update
    respond_to do |format|
      if @meetup.update(meetup_params)
        format.html { redirect_to @meetup, notice: 'Meetup was successfully updated.' }
        format.json { render :show, status: :ok, location: @meetup }
      else
        format.html { render :edit }
        format.json { render json: @meetup.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /meetups/1
  # DELETE /meetups/1.json
  def destroy
    @meetup.destroy
    respond_to do |format|
      format.html { redirect_to meetups_url, notice: 'Meetup was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_meetup
    @meetup = Meetup.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def meetup_params
    params.require(:meetup).permit(
      :title, :open_at, :close_at, :deadline, :place, :intro,
      meetup_fees_attributes: [:id, :key, :real_value, :quota, :_destroy])
  end
end
