class UserService

  def all_users
    get_json(conn.get("/api/v1/users"))
  end

  def single_user(id)
    get_json(conn.get("/api/v1/users/#{id}"))
  end

  def get_json(response)
    JSON.parse(response.body, symbolize_names: true)
  end 

  def conn
    Faraday.new(url: "http://localhost:3000")
  end
end