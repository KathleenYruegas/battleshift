class UserService
  attr_reader :filter

  def initialize(filter = {})
    @filter = filter
  end

  def single_user_data
    get_json("/api/v1/users/#{filter[:id]}")
  end

  def all_user_data
    get_json("/api/v1/users")
  end

  def update_user_data(new_email)
    # refactor by taking params out of URI
    conn.patch("/api/v1/users/#{filter[:id]}?email=#{new_email}")
  end

  private

  def conn
    Faraday.new(ENV["API_DOMAIN_NAME"]) do |faraday|
      faraday.adapter Faraday.default_adapter
    end
  end

  def get_json(url)
    JSON.parse(conn.get(url).body, symbolize_names: true)
  end
end
