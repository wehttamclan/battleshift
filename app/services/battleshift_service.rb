class BattleshiftService

  def all_users
    get_json(conn.get("/api/v1/users"))
  end

  def find_user(id)
    get_json(conn.get("/api/v1/users/#{id}"))
  end

  def get_json(response)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: ENV["root_url"])
  end

  def update_email(id, email)
    conn.put("/api/v1/users/#{id}", email: "#{email}")
  end
end
