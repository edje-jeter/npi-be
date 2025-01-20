require "net/http"
require "json"

module Nppes
  class ProviderByNpi
    BASE_URL = "https://npiregistry.cms.hhs.gov/api"
    VERSION = "2.1"

    def initialize(npi)
      @npi = npi
    end

    def call
      response = ::Net::HTTP.get_response(uri)
      parsed = parse_response(response)
      format_response(parsed)
    end

  private

    def combined_error_msg(body)
      body.dig("Errors").map { |error| error.dig("description") }.join("; ")
    end

    def failure_response(response)
      { error: response.message, status: response.code }
    end

    def format_response(parsed)
      return parsed if parsed[:error]

      {
        address_1: parsed.dig("addresses")&.first&.dig("address_1"),
        address_2: parsed.dig("addresses")&.first&.dig("address_2"),
        city: parsed.dig("addresses")&.first&.dig("city"),
        country_code: parsed.dig("addresses")&.first&.dig("country_code"),
        country_name: parsed.dig("addresses")&.first&.dig("country_name"),
        credential: parsed.dig("basic", "credential"),
        name_first: parsed.dig("basic", "first_name"),
        name_last: parsed.dig("basic", "last_name"),
        name_middle: parsed.dig("basic", "middle_name"),
        name_organization: parsed.dig("basic", "organization_name"),
        npi: parsed.dig("number"),
        nppes_last_updated: parsed.dig("basic", "last_updated"),
        nppes_type: parsed.dig("enumeration_type"),
        postal_code: parsed.dig("addresses")&.first&.dig("postal_code"),
        primary_taxonomy: parsed.dig("taxonomies")&.find { |taxonomy| taxonomy["primary"] }&.dig("desc"),
        state: parsed.dig("addresses")&.first&.dig("state")
      }
    end

    def parse_response(response)
      # NOTE: for NPPES, 200 means a response was given, not that the result is valid
      return failure_response(response) unless response.is_a?(::Net::HTTPSuccess)

      parsed_body = ::JSON.parse(response.body)

      if parsed_body.dig("Errors").present?
        { error: combined_error_msg(parsed_body) }
      elsif parsed_body.dig("results") == []
        { error: "No provider found for NPI: #{@npi}." }
      else
        parsed_body.dig("results")&.first
      end
    end

    def uri
      uri = URI(BASE_URL)
      uri.query = ::URI.encode_www_form({ number: @npi, version: VERSION })

      uri
    end
  end
end
