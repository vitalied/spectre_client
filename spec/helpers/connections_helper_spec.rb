require 'rails_helper'

RSpec.describe ConnectionsHelper, type: :helper do
  describe "can_refresh_connection?" do
    it "can refresh connection" do
      connection = { 'next_refresh_possible_at' => 1.minute.ago.utc.to_s }
      expect(helper.can_refresh_connection?(connection)).to be true
    end

    it "can't refresh connection" do
      connection = { 'next_refresh_possible_at' => 1.minute.from_now.utc.to_s }
      expect(helper.can_refresh_connection?(connection)).to be false
    end
  end
end
