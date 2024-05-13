# typed: true

class ModelsController < ApplicationController
  def new
    @model = ValueModel.new
  end

  def list
    @models = ValueModel.all
  end

  def show; end

  def create
    @model = ValueModel.new(name: params[:title])
    csv_text = File.read(params[:file])
    csv = CSV.parse(csv_text, headers: true)
    puts csv.length
    if csv.length != 262
      @model.errors.add(:base, 'File must have exactly 262 rows')
      render :new, status: :unprocessable_entity
      return
    end
    csv.each do |row|
      @model.value_model_pick.new(pick: row[0], value: row[1])
    end
    if @model.save
      redirect_to models_list_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def download
    model = ValueModel.find(params[:id])
    send_data model.to_csv, filename: "#{model.name}-model.csv"
  end

  def delete
    model = ValueModel.find(params[:id])
    model.destroy
    redirect_to models_list_path
  end

  private

  def model_params
    params.require(:model).permit(:name)
  end
end
