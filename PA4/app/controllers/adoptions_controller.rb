class AdoptionsController < ApplicationController
  before_filter :signed_in_user, only: [:edit, :create, :new, :update, :destroy]

  # GET /adoptions
  # GET /adoptions.json
  def index
    @adoptions = Adoption.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @adoptions }
    end
  end

  def mobiledownload
    @adoptions = Adoption.all
    render json: @adoptions
  end

  def mobileupload
    @user = User.find_by_email(params[:email])
    @adoption = Adoption.new(title: params[:title], descr: params[:descr])
  end

  # GET /adoptions/1
  # GET /adoptions/1.json
  def show
    @adoption = Adoption.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @adoption }
    end
  end

  # GET /adoptions/new
  # GET /adoptions/new.json
  def new
    @adoption = Adoption.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @adoption }
    end
  end

  # GET /adoptions/1/edit
  def edit
    @adoption = Adoption.find(params[:id])
  end

  # POST /adoptions
  # POST /adoptions.json
  def create
    @adoption = Adoption.new(params[:adoption])
    @adoption.user_id = current_user.id

    respond_to do |format|
      if @adoption.save
        format.html { redirect_to @adoption, notice: 'Adoption was successfully created.' }
        format.json { render json: @adoption, status: :created, location: @adoption }
      else
        format.html { render action: "new" }
        format.json { render json: @adoption.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /adoptions/1
  # PUT /adoptions/1.json
  def update
    @adoption = Adoption.find(params[:id])

    respond_to do |format|
      if @adoption.update_attributes(params[:adoption])
        format.html { redirect_to @adoption, notice: 'Adoption was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @adoption.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /adoptions/1
  # DELETE /adoptions/1.json
  def destroy
    @adoption = Adoption.find(params[:id])
    @adoption.destroy

    respond_to do |format|
      format.html { redirect_to adoptions_url }
      format.json { head :no_content }
    end
  end

  private
    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_path, notice: "Please sign in."
      end
    end
end
