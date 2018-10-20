--Provide the number of commons, uncommons, rares and mythics from the simulated set
--https://en.wikipedia.org/wiki/List_of_Magic:_The_Gathering_sets

commons = 111
uncommons = 80
rares = 53
mythics = 15

--What is the booster structure? Paper: 12,2,1; Arena: 5,2,1
booster_commons = 5
booster_uncommons = 2

-- Mythic rare chance? Paper: 1 out of 8
mythic_out_of = 8

--Write out the quantities of the cards you want to have inside the brackets.
--The quantities can be in any order.
--Card names are not relevant for the simulation.
--Use {}, {0} when you do not want any of a specific rarity

--Default data is for a deck of cards where there are 3 mythics, 7 rares, 11 uncommons, and 15 commons. (26 lands)
wanted_commons   = {2,1}
wanted_uncommons = {2,3,2}
wanted_rares     = {1,2,3,3,2}
wanted_mythics   = {4,3,3,3,2}

--Run the simulation several times for better understanding on the odds.
simulations = 10

function number_array(n)
    output = {}

    for i = 1,n do
        table.insert(output, i)
    end

     return output
end

function zero_array(n)
    output = {}

    for i = 1,n do
        table.insert(output, 0)
    end

     return output
end

function playset_array(n)
    output = {}

    for i = 1,n do
        table.insert(output, 4)
    end

     return output
end

function shuffle(input)
    output = {}

    while #input > 0 do
        selection = math.random(#input)
        table.insert(output, input[selection])
        table.remove(input, selection)
    end

    return output
end

purchases = 0
function buy_boosters()
    purchases = purchases + 1
    mythic_chance = math.random(mythic_out_of)

    booster.c = shuffle(booster.c)
    booster.u = shuffle(booster.u)
    booster.r = shuffle(booster.r)
    booster.m = shuffle(booster.m)
end

function add_to_collection()
    for i = 1,booster_commons do collection.c[booster.c[i]] = collection.c[booster.c[i]] + 1 end
    for i = 1,booster_uncommons do collection.u[booster.u[i]] = collection.u[booster.u[i]] + 1 end

    if mythic_chance == 1 and #booster.m > 0 then
        for i = 1,1 do collection.m[booster.m[i]] = collection.m[booster.m[i]] + 1 end
    else
        for i = 1,1 do collection.r[booster.r[i]] = collection.r[booster.r[i]] + 1 end
    end
end

function enough_cards()
    for _,rarity in pairs({"c","u","r","m"}) do
        for i = 1,#deck[rarity] do
            if collection[rarity][i] < deck[rarity][i] then
                return false
            end
        end
    end

    return true
end

function reset_collection()
  collection = {}
  collection.c = zero_array(commons)
  collection.u = zero_array(uncommons)
  collection.r = zero_array(rares)
  collection.m = zero_array(mythics)
end

deck = {}
deck.c = wanted_commons
deck.u = wanted_uncommons
deck.r = wanted_rares
deck.m = wanted_mythics

booster = {}
booster.c = number_array(commons)
booster.u = number_array(uncommons)
booster.r = number_array(rares)
booster.m = number_array(mythics)

reset_collection()

for i = 1,simulations do
  while not enough_cards() do
      buy_boosters()
      add_to_collection()
  end

  reset_collection()
end

print(purchases/simulations..(" (average of "..simulations.." simulations)"))