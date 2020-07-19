class CompaniesController < ApplicationController
  before_action :set_company, except: [:index, :create, :new]

  def index
    @companies = Company.all
  end

  def new
    @company = Company.new
  end

  def show
  end

  def create
    @company = Company.new(company_params)
    if @company.save
      redirect_to companies_path, notice: "Saved"
    else
      flash_error_message
      render :new
    end
  end

  def edit
  end

  def update
    if @company.update(company_params)
      redirect_to companies_path, notice: "Changes saved successfully."
    else
      flash_error_message
      render :edit
    end
  end  

  def destroy
    if @company.destroy
      redirect_to companies_path, notice: "Company has been deleted successfully."
    else
      flash_error_message
      render :show
    end
  end

  private

  def company_params
    params.require(:company).permit(
      :name,
      :legal_name,
      :description,
      :zip_code,
      :phone,
      :email,
      :owner_id,
    )
  end

  def set_company
    @company = Company.find(params[:id])
    rescue ActiveRecord::RecordNotFound => error
    redirect_to companies_path, notice: "#{error}"
  end

  def flash_error_message
    flash.now[:error] = @company.errors.full_messages[0]  if @company && @company.errors
  end
  
end
