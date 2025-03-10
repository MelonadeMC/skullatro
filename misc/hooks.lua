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

-- wtf is going wrong im leaving this for later
-- local card_is_suit_ref = Card.is_suit
-- function Card:is_suit(suit, bypass_debuff, flush_calc)
--     for i = 1, #G.jokers.cards do
--         if G.jokers.cards[i].label == "Parasoul" then
--             if G.jokers.cards[i].ability.extra.foundQoS == true then
--                 return true
--             end
--         end
--     end

--     self:card_is_suit_ref(suit, bypass_debuff, flush_calc)
-- end

local sell_card_ref = Card.sell_card
function Card:sell_card()
    SMODS.calculate_context({card_sold = true , card_being_sold = self})
    --print(self.label .. " sold")
    sell_card_ref(self)
end