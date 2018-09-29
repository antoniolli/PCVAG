require_relative 'genetic_algorithm'

ga = GeneticAlgorithm.new

crossover_rate = 0.8
mutation_rate = 0.015
max_generations = 500
max_population = 400

for i in 0..4
  ga.run(crossover_rate, mutation_rate, max_generations, max_population)
end

