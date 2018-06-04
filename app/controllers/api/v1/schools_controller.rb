class Api::V1::SchoolsController < Api::ApiController

  # DOC GENERATED AUTOMATICALLY: REMOVE THIS LINE TO PREVENT REGENERATING NEXT TIME
  api :GET, '/v1/schools', 'List schools'
  # param :status, :boolean
  error code: 401
  def index
    render json: {schools: School.filter(params)}.to_json
  end

  # DOC GENERATED AUTOMATICALLY: REMOVE THIS LINE TO PREVENT REGENERATING NEXT TIME
  api :POST, '/v1/schools', 'Create a school'
  error code: 422
  def create
    school = School.create(school_params)
    if school.errors.any?
      render json: {success: false, errors: school.errors.messages}, status: 422
    else
      render json: {success: true, school: school}, status: 201
    end
  end

  # DOC GENERATED AUTOMATICALLY: REMOVE THIS LINE TO PREVENT REGENERATING NEXT TIME
  api :GET, '/v1/schools/:id', 'Show a school'
  def show
    school = School.find(params[:id])
    if school.blank?
      render json: {success: false}, status: 401
    else

    end
    render json: {
      success: true,
      school: school
    }
  end

  # DOC GENERATED AUTOMATICALLY: REMOVE THIS LINE TO PREVENT REGENERATING NEXT TIME
  api :PATCH, '/v1/schools/:id', 'Update a school'
  api :PUT, '/v1/schools/:id', 'Update a school'
  def update

    school = School.find(params[:id])

    school_params.each do |p|
      school[p] = school_params[p]
    end

    school.save

    render json: {
      success: true,
      school: school
    }

  end

  # DOC GENERATED AUTOMATICALLY: REMOVE THIS LINE TO PREVENT REGENERATING NEXT TIME
  api :DELETE, '/v1/schools/:id', 'Destroy a school'
  def destroy

    School.delete(params[:id])
    render json: {success: true}

  end

  private
  def school_params

    params.require(:school).permit(
      :nom,
      :adresse,
      :zip_code,
      :city,
      :openings,
      :phone,
      :email,
      :nb_student,
      :status,
      :latitude,
      :longitude
    )

  end

end
