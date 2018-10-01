require_relative 'util'

class Chromosome
	SIZE = 28

	attr_reader :value, :fitness_value, :distance

	def initialize(value)
		@value = value
		@fitness_value = 0
		fitness()
	end

	def fitness()
		@fitness_value = Util.calculateDistances(@fitness_value, @value)
	end

	def mutate(probability_of_mutation)
		@value = rand < probability_of_mutation ? changeIndex(value) : value
	end

	def changeIndex(ch)
		first_rnd = rand(0...6)
		second_rnd = rand(0...6)
		begin
			second_rnd = rand(0...6)
		end until first_rnd != second_rnd

		ch[first_rnd], ch[second_rnd] = ch[second_rnd], ch[first_rnd]

		ch
	end
end
