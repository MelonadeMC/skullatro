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
    cost = 5,
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
        if context.food_joker_destroyed then
            G.E_MANAGER:add_event(Event({
                func = function() 
                    card.ability.extra.currentMult = card.ability.extra.currentMult + 5
                    card:juice_up(1, 0.25)
                    return true 
                end
            }))
            return {
                message = "+5 Mult",
                colour = G.C.RED
            }
        end

        if context.joker_main then
            return {
                card = card,
                mult = card.ability.extra.currentMult
            }
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
    cost = 8,
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

SMODS.Joker{
    name = "Peacock",
    key = "peacock",
    loc_txt = {
        name = "Peacock",
        text = {
            "{C:green}#1# in #2#{} chance for",
            "any {C:attention}played 8s{} to be",
            "copied and redrawn",
            "when scored"
        }
    },
    rarity = 2,
    cost = 5,
    blueprint_compat = true,
    atlas = "skullatroJokers",
    pos = {x = 4, y = 0},
    config = {
        extra = {
            probability = 1,
            chance = 2
        }
    },
    loc_vars = function(self,info_queue,card)
        card.ability.extra.probability = G.GAME.probabilities.normal
        return { vars = {
            card.ability.extra.probability,
            card.ability.extra.chance
        } }
    end,
    calculate = function(self,card,context)
        if context.individual and context.cardarea == G.play then
            --print(context.other_card:get_id())
            if context.other_card:get_id() == 8 then
                local randomchance = pseudorandom("peacock", card.ability.extra.probability, card.ability.extra.chance)
                print(randomchance)
                if randomchance <= card.ability.extra.probability then
                    local _card = copy_card(context.other_card, nil, nil, G.playing_card)
                    _card:add_to_deck()
                    G.deck.config.card_limit = G.deck.config.card_limit + 1
                    table.insert(G.playing_cards, _card)
                    G.hand:emplace(_card)
                    _card.states.visible = nil

                    G.E_MANAGER:add_event(Event({
                        func = function()
                            _card:start_materialize()
                            return true
                        end
                    })) 

                    return {
                        message = localize('k_copied_ex'),
                        colour = G.C.CHIPS,
                        card = card,
                        playing_cards_created = {true}
                    }
                end
            end
        end
    end
}