

SMODS.Joker{
    name = "Filia",
    key = "filia",
    loc_txt = {
        name = "Filia",
        text = {
            "Gains {C:mult}+5{} Mult any time",
            "a Food Joker {C:attention}expires{}",
            "(Currently {C:mult}+#1#{} Mult)"
        }
    },
    rarity = 2,
    blueprint_compat = true,
    atlas = "skullatroJokers",
    pos = {x = 6, y = 0},
    config = {
        extra = {
            currentMult = 0
        }
    },
    loc_vars = function(self,info_queue,card)
        return { vars = {
            card.ability.extra.currentMult
        } }
    end,
    calculate = function(self,card,context)
        --print(context.food_joker_destroyed)
        if context.food_joker_destroyed then
            print("destroying food joker")
        end
    end
}

SMODS.Joker{
    name = "Cerebella",
    key = "cerebella",
    loc_txt = {
        name = "Cerebella",
        text = {
            "Each {C:diamonds}Diamond{} held in hand",
            "gives {X:mult,C:white}X1.25{} Mult"
        }
    },
    rarity = 3,
    blueprint_compat = true,
    atlas = "skullatroJokers",
    pos = {x = 7, y = 0},
    config = {
        extra = {
            triggered = false,
            xmult = 1.25
        }
    },
    loc_vars = function(self,info_queue,card)
        return { vars = {
            card.ability.extra.triggered,
            card.ability.extra.xmult
        } }
    end,
    calculate = function(self,card,context)
        if context.joker_main then
            if card.ability.extra.triggered == true then
                if pseudorandom("cerebella", 1, 500) == 1 then
                    print("cat (it doesn't exist yet)")
                end
                -- and whatever else happens if its triggered it has to do with other jokers that arent implemented yet
            end
        end

        if context.individual and context.cardarea == G.hand and not context.end_of_round then
            if context.other_card:is_suit('Diamonds') then
                card.ability.extra.triggered = true
                if context.other_card.debuff then
                    return {
                        card = card,
                        message = localize('k_debuffed'),
                        colour = G.C.RED
                    }
                else
                    return {
                        card = card,
                        x_mult = card.ability.extra.xmult
                    }
                end
            end
        end

        if context.after and context.cardarea == G.play or context.end_of_round then
            card.ability.extra.triggered = false
        end
    end
}