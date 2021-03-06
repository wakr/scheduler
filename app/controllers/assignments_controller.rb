class AssignmentsController < ApplicationController
  before_action :set_assignment, only: [:show, :edit, :update, :destroy]
  before_action :ensure_that_user_is_signed_in

  # GET /assignments
  # GET /assignments.json
  def index
    @assignments = current_user.assignments


    if @assignments.count == 0
      render :error_page
    else
      render :index
    end

  end

  # GET /assignments/1
  # GET /assignments/1.json
  def show
    @tasks = @assignment.tasks
    @assignment.is_ready
  end

  # GET /assignments/new
  def new

    if User.all_who_are_in_same_group_as_creator(current_user).empty? # user not in any group
      redirect_to groups_path, alert: "Please join to some group with people first or wait until there are people in your group."
    end

    @assignment = Assignment.new
    @assignment.user_assignments.build
    @members = User.all_who_are_in_same_group_as_creator(current_user)
  end

  # GET /assignments/1/edit
  def edit
    @assignment = Assignment.new
    @assignment.user_assignments.build # required for nested structure?
    @users = User.all_except(current_user) # users can't assign themselves
  end

  # POST /assignments
  # POST /assignments.json
  def create
    @assignment = Assignment.new(assignment_params)
    @assignment.creator_id = current_user.id

    # THIS IS ONLY FOR CREATING ASSIGNMENT FOR THE VERY FIRST TIME
    # if users wants to add more users to this, edit should be used and user_assignment_controller for it
    respond_to do |format|
      if @assignment.save
        current_user.assignments << @assignment
        @assignment.update_attribute(:is_done, false)
        @assignment.user_assignments.first.update_attribute(:assignment_id, @assignment.id) # for each?
        format.html { redirect_to current_user, notice: 'Assignment was successfully created.' }
        format.json { render :show, status: :created, location: @assignment }
      else
        format.html { redirect_to :back }
        format.json { render json: @assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /assignments/1
  # PATCH/PUT /assignments/1.json
  def update
    respond_to do |format|
      if @assignment.update(assignment_params)
        format.html { redirect_to @assignment, notice: 'Assignment was successfully updated.' }
        format.json { render :show, status: :ok, location: @assignment }
      else
        format.html { render :edit }
        format.json { render json: @assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /assignments/1
  # DELETE /assignments/1.json
  def destroy
    if current_user.id != @assignment.creator_id
      redirect_to request.env['HTTP_REFERER'] || :root, notice: 'You are not authorized to delete assignments'
      return
    end

    @assignment.destroy
    respond_to do |format|
      format.html { redirect_to :root, notice: 'Assignment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_assignment
      @assignment = Assignment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def assignment_params
      params.require(:assignment).permit(:name, :is_done, :deadline, :group_id, user_assignments_attributes: [:user_id])
    end

end
