class ProvidersController < ApplicationController
  INDEX_SIZE_LIMIT = 50

  # FUTURE: add pagination
  def index
    @pproviders = ::Provider.order(last_pulled_from_nppes_at: :desc).limit(INDEX_SIZE_LIMIT)
    render json: @pproviders
  end

  def create
    @provider = ::Provider.find_or_initialize_by(npi: params_for_create["npi"])

    provider_data = ::Nppes::ProviderByNpi.new(params_for_create["npi"]).call
    @provider.update(provider_data)
    @provider.update(last_pulled_from_nppes_at: ::Time.current.utc)

    if @provider.save
      render json: @provider, status: :created
    else
      render json: @provider.errors, status: :unprocessable_entity
    end
  end

  private

  def params_for_create
    params.require(:provider).permit(:npi)
  end
end
