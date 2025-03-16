--- STEAMODDED HEADER
--- MOD_NAME: MIKUXBALATRO
--- MOD_ID: MIKUXBALATRO
--- MOD_AUTHOR: [MISENROL]
--- MOD_DESCRIPTION: Miku and Friends join Jimbo!
--- PREFIX: mikuxbalatro

SMODS.Atlas{
    key = 'Jokers',
    path = 'Jokers.png',
    px = 71,
    py = 95
}

SMODS.Sound({
    key = 'neru_camera',
    path = 'shutter.ogg',
    replace = true
})

Miku = {Jimbo_Miku}
Teto = {Jimbo_Teto}

SMODS.Joker{
    key = 'Jimbo_Miku',
    loc_txt = {
        name = 'Jimbo Miku',
        text = {
            'For every {C:clubs}Club{} played in hand,',
            '{C:mult}+2 Mult{} and',
            '{C:chips}+5 Chips{}'
        }
    },
    config = { extra = { chips = 5, mult = 2 } },
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'Jokers',
    pos = { x = 0, y = 0 },
    cost = 4,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, card.ability.extra.chips } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:is_suit('Clubs') then
                return {
                    mult = card.ability.extra.mult,
                    chips = card.ability.extra.chips,
                    card = other
                }
            end
        end
    end
}

SMODS.Joker{
    key = 'Jimbo_Teto',
    loc_txt = {
        name = 'Jimbo Teto',
        text = {
            'For every {C:mult}Discard{} left,',
            '{C:mult}+5 Mult{} and',
            'for every {C:chips}Hand{} left {C:chips}+20 Chips{}'
        }
    },
    config = { extra = { chips = 20, mult = 5 } },
    rarity = 1,
    atlas = 'Jokers',
    pos = { x = 1, y = 0 },
    cost = 3,
    blueprint_compat = true,
    eternal_compat = true,
    unlock_card = true,
    discovered = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, card.ability.extra.chips } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            return {
                mult = G.GAME.current_round.discards_left * card.ability.extra.mult,
                chips = G.GAME.current_round.hands_left * card.ability.extra.chips
            }
        end
    end
}

SMODS.Joker{
    key = 'Shiteyanyo',
    loc_txt = {
        name = 'Shiteyanyo',
        text = {
            'Retriggers all played cards if,',
            'played {C:attention}hand{} is a {C:attention}Two Pair{}',
        }
    },
    config = { extra = { repetitions = 1 } },
    rarity = 1,
    cost = 4,
    blueprint_compat = true,
    eternal_compat = true,
    unlock_card = true,
    discovered = true,
    atlas = 'Jokers',
    pos = { x = 2, y = 0 },
    calculate = function(self, card, context)
        if context.cardarea == G.play and context.repetition then
			if (next(context.poker_hands['Two Pair'])) then
				return {
					message = 'Again!',
					repetitions = card.ability.extra.repetitions,
					card = context.other_card
				}  
            end
        end
    end
}

SMODS.Joker{
    key = "Kaito_Icelolly",
    loc_txt = {
        name = "Kaito's Ice Lolly",
        text = {
            'If hand contains a {C:attention}Straight{},',
            'gain {C:mult}x0.25 Mult{}',
            '{C:inactive}(Currently {C:mult}x#1#{C:inactive}Mult)',
        }
    },
    config = { extra = { Xmult = 1, Xmult_gain = 0.25 } },
    rarity = 2,
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    unlock_card = true,
    discovered = true,
    atlas = 'Jokers',
    pos = { x = 3, y = 0},
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.Xmult, card.ability.extra.Xmult_gain } }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            return {
                Xmult_mod = card.ability.extra.Xmult,
                message = localize { type = 'variable', key = 'a_xmult', vars = {card.ability.extra.Xmult } }

            }
        end
        if context.before and next(context.poker_hands['Straight']) and not context.blueprint then
            card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_gain
            return {
                   message = 'More!',
                   colour = G.C.MULT,
                   card = card
            }
        end
    end
}

SMODS.Joker{
    key = 'Gumis_Carrot',
    loc_txt ={
        name = "Gumi's Carrot",
        text = {
            'For every {C:attention}Ace{},',
            'played in hand gain {C:mult}x0.2 Mult{},',
            '{C:inactive}(Currently {C:mult}x#1#{C:inactive}Mult)',
        }
    },
    config = { extra = { Xmult = 1, Xmult_gain = 0.2 } },
    rarity = 2,
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    unlock_card = true,
    discovered = true,
    atlas = 'Jokers',
    pos = { x = 4, y = 0},
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.Xmult, card.ability.extra.Xmult_gain } }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            return {
                Xmult_mod = card.ability.extra.Xmult,
                message = localize { type = 'variable', key = 'a_xmult', vars = {card.ability.extra.Xmult } }

            }
        end
        if context.individual and context.cardarea == G.play then
            if context.other_card:get_id() == 14 then
                card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_gain
                return {
                       message = 'More Carrots!',
                       colour = G.C.MULT,
                       card = card
             
               }
            end
        end
    end

}

SMODS.Joker{
    key = 'Neru_Smartphone',
    loc_txt = {
        name = "Neru's Smartphone",
        text = {
            'For every face card played',
            'gain {C:mult}x1 Mult{},',
            'resets each blind',
            '{C:inactive}(Currently {C:mult}x#1#{C:inactive}Mult)'
        }
    },
    config = { 
        extra = { 
            Xmult = 1,
            Xmult_gain = 1
        }
    },
    rarity = 3,
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    unlock_card = true,
    discovered = true,
    atlas = 'Jokers',
    pos = { x = 5, y = 0 },
    loc_vars = function(self, info_queue, card)
        return { vars = {
            card.ability.extra.Xmult, 
            card.ability.extra.Xmult_gain 
        } }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            return {
                Xmult_mod = card.ability.extra.Xmult,
                message = localize { type = 'variable', key = 'a_xmult', vars = {card.ability.extra.Xmult } }

            }
        end
        if context.individual and context.cardarea == G.play and context.other_card:is_face() then
            card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_gain
            play_sound(mikuxbalatro_neru_camera, 1, 10)
            return{
                message = 'Selfie!',
                play_sound(mikuxbalatro_neru_camera, 1, 3),
                colour = G.C.YELLOW,
                card = card,
            }
        end
        if context.end_of_round and not context.repetition and context.game_over == false and not context.blueprint then
            card.ability.extra.Xmult = 1
            return {
                message = 'Phone died!',
                colour = G.C.RED
            }
        end
    end
}
SMODS.Joker{
    key = 'Jimbo_Kaito',
    loc_txt = {
        name = 'Jimbo Kaito',
        text = {
            'Retriggers all played cards if,',
            'played {C:attention}hand{} is a {C:attention}Straight{}',
        }
    },
    config = { extra = { repetitions = 1 } },
    rarity = 1,
    cost = 4,
    blueprint_compat = true,
    eternal_compat = true,
    unlock_card = true,
    discovered = true,
    atlas = 'Jokers',
    pos = { x = 6, y = 0 },
    calculate = function(self, card, context)
        if context.cardarea == G.play and context.repetition then
			if (next(context.poker_hands['Straight'])) then
				return {
					message = 'Again!',
					repetitions = card.ability.extra.repetitions,
					card = context.other_card
				}
            end
        end
    end
}