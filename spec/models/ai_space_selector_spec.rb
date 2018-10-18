require 'rails_helper'

describe Board, type: :model do
  describe 'methods' do
    before(:each) do
      @board = Board.new(4)
      @aiss = AiSpaceSelector.new(@board)
    end
    it '#fire' do
      expect(@aiss.fire!).to eq("Miss")
    end
  end
end
