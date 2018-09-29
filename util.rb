require 'csv'

class Util
    attr_reader :distance_matrix
    def self.pmx(ind1, ind2)
            size = [ind1.length, ind2.length].min
            p1, p2 = [0]*size, [0]*size

            # Initialize the position of each indices in the individuals
            for i in 0...size
                p1[ind1[i]] = i
                p2[ind2[i]] = i
            end

            # Choose crossover points
            cxpoint1 = rand(0...size)
            cxpoint2 = rand(0...size - 1)

            if cxpoint2 >= cxpoint1
                cxpoint2 += 1
            else # Swap the two cx points
                cxpoint1, cxpoint2 = cxpoint2, cxpoint1
            end

            # Apply crossover between cx points
            for i in cxpoint1...cxpoint2
                # Keep track of the selected values
                temp1 = ind1[i]
                temp2 = ind2[i]
                # Swap the matched value
                ind1[i], ind1[p1[temp2]] = temp2, temp1
                ind2[i], ind2[p2[temp1]] = temp1, temp2
                # Position bookkeeping
                p1[temp1], p1[temp2] = p1[temp2], p1[temp1]
                p2[temp1], p2[temp2] = p2[temp2], p2[temp1]
            end

            return ind1, ind2
    end

    def self.calculateDistances(distance_cities, chromosome_value)
        distance_matrix = CSV.read("bays29.csv")
        if (distance_cities == 0)
                dist = 0;
                initial_city = chromosome_value[0]
                for i in 0..chromosome_value.length-1
                    origin_city = chromosome_value[i]
                    destiny_city = chromosome_value[i+1]
                    if i+1 < chromosome_value.length
                        dist = distance_matrix[origin_city][destiny_city].to_i
                    else
                        dist = distance_matrix[origin_city][initial_city].to_i
                    end
                    distance_cities += dist
                end
        end
        distance_cities
    end
end
