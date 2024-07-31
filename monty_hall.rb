class MontyHall
  attr_reader :doors, :prize_door, :choice, :open_door, :final_choice

  def initialize
    @doors = [1, 2, 3]
    @prize_door = rand(1..3)
    @choice = rand(1..3)
    @open_door = nil
    @final_choice = nil
  end

  def open_door
    @open_door = (doors.clone - [@prize_door, @choice]).sample
  end

  def final_choice(switch)
    @final_choice = if switch
                      (doors.clone - [@choice, @open_door]).first
                    else
                      @choice
                    end
  end

  def win?
    @final_choice == @prize_door
  end
end

class MontyHallSimulation
  def initialize(iterations)
    @iterations = iterations
    @wins_if_switch = 0
    @wins_if_stay = 0
  end

  def run
    @iterations.times do
      game = MontyHall.new
      game.choice
      game.open_door

      game.final_choice(true)
      @wins_if_switch += 1 if game.win?

      game.final_choice(false)
      @wins_if_stay += 1 if game.win?
    end

    print_results
  end

  private

  def print_results
    puts "Выигрыш при смене выбора: #{@wins_if_switch} раз (#{percentage(@wins_if_switch)}%)"
    puts "Выигрыш при сохранении выбора: #{@wins_if_stay} раз (#{percentage(@wins_if_stay)}%)"
  end

  def percentage(wins)
    (wins.to_f / @iterations * 100).round(2)
  end
end

simulation = MontyHallSimulation.new(10_000)
simulation.run
