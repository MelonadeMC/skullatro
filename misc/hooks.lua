local temporarySolutionFoodJokersArray = {"Ramen", "Cavendish", "Popcorn", "Ice Cream", "Turtle Bean", "Seltzer", "Diet Cola", "Gros Michel"}

-- add joker_destroyed context
local card_remove_ref = Card.remove
function Card:remove()
    if self.added_to_deck and self.ability.set == "Joker" and not G.CONTROLLER.locks.selling_card then
        for _,v in pairs(temporarySolutionFoodJokersArray) do
            if v == self.label then
                --print(self.label)
                SMODS.calculate_context({food_joker_destroyed = true , card_destroyed = self})
            end
        end
    end
    card_remove_ref(self)
end