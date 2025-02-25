SMODS.Joker{
    name = "Filia",
    key = "filia",
    loc_txt = {
        name = "Filia",
        text = {
            "{C:green}#1# in #2#{} chance to disable",
            "{C:attention}Boss Blind{} effect at",
            "the start of the round."
        }
    },
    rarity = 2,
    blueprint_compat = false,
    atlas = "filiaAtlas",
    pos = {x = 0, y = 0},
    config = {
        extra = {
            probability = 1,
            chance = 5
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
        -- TODO: make it so it only works on boss blinds (i have no idea what context is used for this)
        if context.setting_blind then
            if pseudorandom("filia", card.ability.extra.probability, card.ability.extra.chance) <= card.ability.extra.chance then
                G.E_MANAGER:add_event(Event({func = function()
                    G.E_MANAGER:add_event(Event({func = function()
                        G.GAME.blind:disable()
                        play_sound('timpani')
                        delay(0.4)
                        return true end }))
                    card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('ph_boss_disabled')})
                return true end }))
            end
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
    atlas = "cerebellaAtlas",
    pos = {x = 0, y = 0},
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

        -- TODO: fix joker proccing after end of round
        if context.individual and context.cardarea == G.hand then
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