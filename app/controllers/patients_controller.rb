class PatientsController < ApplicationController
  def index
    @patients = Patient.all
  end

  def show
   @clinic = Clinic.find params[:clinic_id]
   @patient = Patient.find params[:id]
   @medications = @patient.medications
  end


  def new
    @clinic = Clinic.find params[:clinic_id]
    @patient = @clinic.patients.new
    @medications = Medication.all
  end

  def create
    @clinic = Clinic.find params[:clinic_id]
    @medications = Medication.all
    @patient = @clinic.patients.create patient_params
    if @clinic.patients.create
      flash[:notice] = 'Patient info was successfully saved.'
      redirect_to clinic_path(@clinic)
    else
      flash[:error] = 'Patient info was NOT successfully saved.'
      render :new
    end
  end

  def edit
    @clinic = Clinic.find params[:clinic_id]
    @medications = Medication.all
    @patient = @clinic.patients.find params[:id]
  end

  def update
    @clinic = Clinic.find params[:clinic_id]
    @patient = @clinic.patients.find params[:id]
    if @patient.update_attributes patient_params
      flash[:notice] = 'Patient info was successfully updated.'
      redirect_to clinic_path(@clinic)
    else
      flash[:notice] = 'Patient info was NOT successfully updated.'
      render :edit
    end

  end

  def destroy
    @patient = Patient.find params[:id]
    @clinic = Clinic.find params[:clinic_id]
    if @patient.destroy
      flash[:notice] = 'Patient info was successfully deleted.'
      redirect_to clinic_path(@clinic)
    else
      flash[:notice] = 'Patient info was NOT successfully deleted.'
    end
  end


private
  def patient_params
    params.require(:patient).permit(
        :first_name,
        :last_name,
        :date_of_birth,
        :description,
        :gender,
        :blood_type,
        medication_ids: []
      ) 
  end

  def set_clinic
    @clinic = Clinic.find(params[:id])
  end
end
