module ConnectionsHelper

  def can_refresh_connection?(connection)
    time = Time.parse(connection['next_refresh_possible_at'])
    time < Time.now.utc
  end

end
