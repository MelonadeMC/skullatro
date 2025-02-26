local temporarySolutionFoodJokersArray = {"Ramen", "Cavendish", "Popcorn", "Ice Cream", "Turtle Bean", "Seltzer", "Diet Cola", "Gros Michel"}

-- add joker_destroyed context
local card_remove_ref = Card.remove
function Card:remove()
    -- TODO: figure out why food jokers going extinct dont meet the condition????
    if self.label ~= nil and self.label == "Gros Michel" then
        print(self.area)
        print(self.label)
    end
    if self.area and (self.area == G.jokers) then
        for _,v in pairs(temporarySolutionFoodJokersArray) do
            if v == self.label then
                SMODS.calculate_context({food_joker_destroyed = true , card_destroyed = self})
            end
        end
    end
    card_remove_ref(self)
end