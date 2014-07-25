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
      redirect_to person_path(@person)
    else
      @locations = Location.all
      flash.now[:error] = "Assignment could not be created."
      render :new
    end

  end

  private

  def assignment_params
    params.require(:assignment).permit(:location_id, :role)
  end
end