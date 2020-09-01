# frozen_string_literal: true

@infinity = Float::INFINITY

graph = {
  begin: {
    a: 6,
    b: 2
  },
  a: {
    end: 5
  },
  b: {
    a: 3,
    end: 5
  },
  end: {}
}

costs = {
  a: 0,
  b: -1,
  end: @infinity
}

parents = {
  a: :begin,
  b: :begin,
  end: nil
}

@proccessed = []

def find_in_cheapest_cost(costs)
  cheapest_cost = @infinity
  cheapest_cost_node = nil

  costs.each do |index, cost| # varre todos vértices
    # se for o vértice de menor custo até o momento e ainda não tiver sido processado
    if cost < cheapest_cost && !@proccessed.include?(index)
      cheapest_cost = cost # atribui como novo vértice de menor custo
      cheapest_cost_node = index
    end
  end

  cheapest_cost_node
end

node = find_in_cheapest_cost(costs) # encontra o custo mais baixo que ainda não foi processado

until node.nil? # caso todos os vértices tenham sido processados, esse laço será finalizado
  cost = costs[node]
  neighbors = graph[node]

  neighbors.each do |index, neighbor| # percorre todos vizinhos desse vertice
    new_cost = cost + neighbor
    if new_cost < costs[index] # caso seja mais barato hegar a um vizinho a partir desse vértice [...]
      costs[index] = new_cost # [...] atualiza os custos dele
      parents[index] = node # esse vértice se torna o novo pai para o vizinho
    end
  end

  @proccessed << node # marca como processado
  node = find_in_cheapest_cost(costs) # decide qual será o próximo vértice a ser processado
end

puts parents
