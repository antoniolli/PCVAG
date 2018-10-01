require_relative 'genetic_algorithm'

ga = GeneticAlgorithm.new

crossover_rate = 0.8
mutation_rate = 0.012
max_generations = 500
max_population = 400

ga.run(crossover_rate, mutation_rate, max_generations, max_population)
