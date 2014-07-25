class AssignmentsController < ApplicationController
  def new
    @person = Person.find(params[:person_id])
    @assignment = Assignment.new
    @locations = Location.all
  end

  def create
    @person = Person.find(params[:person_id])
    @assignment = Assignment.new(assignment_params.merge(person_id: @person.id))
    if @assignment.save
      redirect_to person_path(@person), notice: 'Assignment created.'
    else
      @locations = Location.all
      flash.now[:error] = "Assignment could not be created."
      render :new
    end

  end

  def edit
    @person = Person.find(params[:person_id])
    @assignment = Assignment.find(params[:id])
    @locations = Location.all

    render :new
  end

  def update
    @person = Person.find(params[:person_id])
    @assignment = Assignment.find(params[:id])
    if @assignment.update_attributes(assignment_params)
      redirect_to person_path(@person), notice: 'Assignment updated.'
    else
      @locations = Location.all
      flash.now[:error] = "Assignment could not be updated."
      render :new
    end
  end

  def destroy
    @person = Person.find(params[:person_id])
    Assignment.find(params[:id]).destroy
    redirect_to person_path(@person), notice: 'Assignment deleted.'
  end

  private

  def assignment_params
    params.require(:assignment).permit(:location_id, :role)
  end
end