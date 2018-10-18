require 'rails_helper'

describe Board, type: :model do
  before(:each) do
    @board = Board.new(4)
  end
  describe "methods" do
    it '#get_row_letters' do
      expect = ["A","B","C","D"]
      expect(@board.get_row_letters).to eq(expect)
    end
    it '#get_column_numbers' do
      expect = ["1","2","3","4"]
      expect(@board.get_column_numbers).to eq(expect)
    end
    it '#space_names' do
      expect = ["A1","A2","A3","A4",
                "B1","B2","B3","B4",
                "C1","C2","C3","C4",
                "D1","D2","D3","D4"]
      expect(@board.space_names).to eq(expect)
    end
    it '#ship_math' do
      @board.ship_math(2)
      expect(@board.ship_places).to eq(3)
      expect(@board.ship_count).to eq(1)
    end
  end
end
