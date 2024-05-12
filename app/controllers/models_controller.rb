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
    if csv.length != 32 * 7
      @model.errors.add(:base, "File must have exactly #{32 * 7} rows")
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

  private

  def model_params
    params.require(:model).permit(:name)
  end
end
