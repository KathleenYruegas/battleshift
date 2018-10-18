require 'spec_helper'
require './app/services/ship_placer'
require './app/models/board'
require './app/models/space'

describe ShipPlacer do
  let(:board) { Board.new(4) }
  let(:ship)  { double(length: 2) }
  subject     { ShipPlacer.new(board: board, ship: ship, start_space: "A1", end_space: "A2") }

  it "exists when provided a board and ship" do
    expect(subject).to be_a ShipPlacer
  end

  it "places the ship within a row with empty spaces" do
    a1 = board.locate_space("A1")
    a2 = board.locate_space("A2")
    a3 = board.locate_space("A3")
    b1 = board.locate_space("B1")

    expect(a1.contents).to be_nil
    expect(a2.contents).to be_nil
    expect(a3.contents).to be_nil
    expect(b1.contents).to be_nil

    subject.run

    expect(a1.contents).to eq(ship)
    expect(a2.contents).to eq(ship)
    expect(a3.contents).to be_nil
    expect(b1.contents).to be_nil
  end

  it "places the ship within a column with empty spaces" do
    a1 = board.locate_space("A1")
    b1 = board.locate_space("B1")

    neighbor_1 = board.locate_space("A2")
    neighbor_2 = board.locate_space("B2")

    expect(a1.contents).to be_nil
    expect(b1.contents).to be_nil
    expect(neighbor_1.contents).to be_nil
    expect(neighbor_2.contents).to be_nil

    ShipPlacer.new(board: board, ship: ship, start_space: "A1", end_space: "B1").run

    expect(a1.contents).to eq(ship)
    expect(b1.contents).to eq(ship)
    expect(neighbor_1.contents).to be_nil
    expect(neighbor_2.contents).to be_nil
  end

  it "doesn't place the ship if it isn't within the same row or column" do
    expect {
      ShipPlacer.new(board: board, ship: ship, start_space: "A1", end_space: "B2").run
    }.to raise_error(InvalidShipPlacement)
  end

  it "doesn't place the ship if the space is occupied when placing in columns" do
    ShipPlacer.new(board: board, ship: ship, start_space: "A1", end_space: "B1").run
    expect {
      ShipPlacer.new(board: board, ship: ship, start_space: "A1", end_space: "B1").run
    }.to raise_error(InvalidShipPlacement)
  end

  it "doesn't place the ship if the space is occupied when placing in rows" do
    ShipPlacer.new(board: board, ship: ship, start_space: "A1", end_space: "A2").run
    expect {
      ShipPlacer.new(board: board, ship: ship, start_space: "A1", end_space: "A2").run
    }.to raise_error(InvalidShipPlacement)
  end

  it "doesn't place the ship if the ship is smaller than the supplied range in a row" do
    expect {
      ShipPlacer.new(board: board, ship: ship, start_space: "A1", end_space: "A3").run
    }.to raise_error(InvalidShipPlacement)
  end

  it "doesn't place the ship if the ship is smaller than the supplied range in a column" do
    expect {
      ShipPlacer.new(board: board, ship: ship, start_space: "A1", end_space: "C1").run
    }.to raise_error(InvalidShipPlacement)
  end

  context '#message' do
    it 'displays a message after placing a ship of length 3' do
      ship_size = 3

      expect(subject.message(ship_size)).to eq("Successfully placed ship with a size of #{ship_size}. You have 1 ship(s) to place with a size of 2.")
    end

    it 'displays a different message regarding a ship of length 2' do
      ship_size = 2

      expect(subject.message(ship_size)).to eq("Successfully placed ship with a size of #{ship_size}. You have 0 ship(s) to place.")
    end
  end
end
