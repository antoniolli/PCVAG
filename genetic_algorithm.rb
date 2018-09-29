
require_relative 'util'
require_relative 'chromosome'

class GeneticAlgorithm
def generate(value = nil)
	if value
		children = []
		for v in value
			child = Chromosome.new(v)
			children << child
		end
		return children
	else
		ch = (1..Chromosome::SIZE).to_a.shuffle
		child = Chromosome.new(ch)
		return child
	end
  end

  def tournament(gladiators)
  	first_parent = gladiators[0].fitness_value <= gladiators[1].fitness_value ? gladiators[0] : gladiators[1]
  	second_parent = gladiators[2].fitness_value <= gladiators[3].fitness_value ? gladiators[2] : gladiators[3]
  	return first_parent, second_parent
  end

  def crossover(parents)
  	children = Util.pmx(parents[0].value, parents[1].value)
  	generate(children)
  end

  def nextGeneration(current_generation, crossover_rate, mutation_rate)
  	next_generation = []
  	(current_generation.size * crossover_rate).to_i.times {

  		# Torneio
        gladiators = current_generation.sample(4)
    	tournament_winners = tournament(gladiators)

        # Cruzamento
    	children = crossover(tournament_winners)
    	children[0].mutate(mutation_rate)
    	children[1].mutate(mutation_rate)

    	next_generation << children[0] << children[1]

      }

      return (current_generation << next_generation).flatten!
  end

  def run(crossover_rate, mutation_rate, max_generations, max_population)
    # Populacao inicial
    population = max_population.times.map { generate() }
    current_generation = population
    next_generation    = []
    generation_count = 0
    best_fit = population.sort_by { |ch| ch.fitness_value }[0]

    while generation_count < max_generations do

		# Salva o melhor fit
		old_fit = best_fit
		best_fit = current_generation.sort_by { |ch| ch.fitness_value }[0]

		if old_fit.fitness_value == best_fit.fitness_value
			generation_count += 1
		else
			generation_count = 0
		end

		next_generation = nextGeneration(current_generation, crossover_rate, mutation_rate)
		current_generation = next_generation.sort_by { |ch| ch.fitness_value}.take(max_population)
    end

    final_best_fit =  current_generation.sort_by { |ch| ch.fitness_value }[0]
    puts final_best_fit.fitness_value
  end
end
