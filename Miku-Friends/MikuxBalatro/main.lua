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
            '{C:mult}+2{} Mult and {C:chips}+5{} Chips'
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
            'For every {C:mult}Discard{} left {C:mult}+1{} Mult and',
            'for every {C:chips}Hand{} left {C:chips}+6{} Chips',
            'per card scored'
        }
    },
    config = { extra = { chips = 6, mult = 1 } },
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
            'gain {X:mult,C:white}x0.25{} Mult',
            '{C:inactive}(Currently {X:mult,C:white}x#1#{C:inactive} Mult)',
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
            'played in hand gain {X:mult,C:white}x0.2{} Mult,',
            '{C:inactive}(Currently {X:mult,C:white}x#1#{C:inactive} Mult)',
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
            'gain {X:mult,C:white}x1{} Mult,',
            'resets each blind',
            '{C:inactive}(Currently {X:mult,C:white}x#1#{C:inactive} Mult)'
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
                    colour = G.C.CHIPS,
					repetitions = card.ability.extra.repetitions,
					card = context.other_card
				}
            end
        end
    end
}

SMODS.Joker {
    key = 'Sketchy_Ticket',
    loc_txt = {
        name = 'Sketchy Ticket',
        text = {
            'Every hand played earn {C:money}+$2{} when scored,',
            '{C:green}#2# in #3#{} chance this',
            'card is destroyed',
            'at the end of the round'
        }
    },
    config = {
        extra = {
            money = 2,
            odds = 3
        }
    },
    rarity = 1,
    cost = 3,
    blueprint_compat = true,
    eternal_compat = false,
    unlock_card = true,
    discovered = true,
    no_pool_flag = 'Sketchy_Ticket_expired',
    atlas = 'Jokers',
    pos = { x = 7, y = 0 },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.money,
                (G.GAME.probabilities.normal or 1),
                card.ability.extra.odds
            }
        }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            if card.ability.extra.money == 2 then
                return {
                  dollars = 2,
                }
            end
        end
        if context.end_of_round and not context.repetition and context.game_over == false and not context.blueprint then
			if pseudorandom('Sketchy_Ticket') < G.GAME.probabilities.normal / card.ability.extra.odds then
				G.E_MANAGER:add_event(Event({
					func = function()
						play_sound('tarot1')
						card.T.r = -0.2
						card:juice_up(0.3, 0.4)
						card.states.drag.is = true
						card.children.center.pinch.x = true
						G.E_MANAGER:add_event(Event({
							trigger = 'after',
							delay = 0.3,
							blockable = false,
							func = function()
								G.jokers:remove_card(card)
								card:remove()
								card = nil
								return true;
							end
						}))
						return true
					end
				}))
				G.GAME.pool_flags.Sketchy_Ticket_expired = true
				return {
					message = 'Expired!'
				}
			else
				return {
					message = 'Safe!'
				}
			end
		end
        
    end
}

SMODS.Joker {
    key = 'VIP_TICKET',
    loc_txt = {
        name = 'VIP TICKET',
        text = {
            'Every card scored, earn {C:money}+$3{},',
            '{C:green}#2# in #3#{} chance this',
            'card is destroyed',
            'at the end of the round'
        }
    },
    config = {
        extra = {
            money = 3,
            odds = 1000
        }
    },
    rarity = 1,
    cost = 5,
    blueprint_compat = true,
    eternal_compat = false,
    unlock_card = true,
    discovered = true,
    yes_pool_flag = 'Sketchy_Ticket_expired',
    atlas = 'Jokers',
    pos = { x = 8, y = 0 },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.money,
                (G.GAME.probabilities.normal or 1),
                card.ability.extra.odds
            }
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
                return {
                  dollars = 3,
                  card = card
                }
            
        end
        if context.end_of_round and context.game_over == false and not context.repetition and not context.blueprint then
			if pseudorandom('VIP_TICKET') < G.GAME.probabilities.normal / card.ability.extra.odds then
				G.E_MANAGER:add_event(Event({
					func = function()
						play_sound('tarot1')
						card.T.r = -0.2
						card:juice_up(0.3, 0.4)
						card.states.drag.is = true
						card.children.center.pinch.x = true
						G.E_MANAGER:add_event(Event({
							trigger = 'after',
							delay = 0.3,
							blockable = false,
							func = function()
								G.jokers:remove_card(card)
								card:remove()
								card = nil
								return true;
							end
						}))
						return true
					end
				}))
				return {
					message = 'Expired!'
				}
			else
				return {
					message = 'Safe!'
				}
			end
		end
	end

}
SMODS.Joker{
    key = 'Triple_Baka',
    loc_txt = {
        name = 'Triple Baka',
        text = {
            'This Joker gains {C:chips}+3{} Chips,',
            'and {C:mult}+3{} Mult,',
            'when a hand contains a {C:attention}3 of a Kind',
            '({C:inactive}Currently {C:chips}+#1#{}{C:inactive} Chips and {C:mult}+#2#{}{C:inactive} Mult{})'
        }
    },
    config = { extra = { chips = 0, mult = 0, chip_gain = 3, mult_gain =3 } },
    rarity = 3,
    cost = 5,
    blueprint_compat = true,
    eternal_compat = true,
    unlock_card = true,
    discovered = true,
    atlas = 'Jokers',
    pos = { x = 0, y = 1 },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult, card.ability.extra.chips, card.ability.extra.mult_gain, card.ability.extra.chip_gain } }
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
        	    chip_mod = card.ability.extra.chips,
                mult_mod = card.ability.extra.mult

            
			}
		end
		if context.before and next(context.poker_hands['Three of a Kind']) and not context.blueprint then
			card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chip_gain
            card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
			return {
				message = 'Upgraded!',
				colour = G.C.CHIPS,
                chips = card.ability.extra.chips,
                mult = card.ability.extra.mult
            
            }
		end
	end
}

SMODS.Joker{
    key = 'Veg_Juice',
    loc_txt = {
        name = 'Vegetable Juice',
        text = {
            'When this Joker is {C:attention}Sold{},',
            'gain a random {C:attention}Tag{}',
            '{C:yellow} ONLY 200 YEN!{}'
            
        }
    },
    config = {
        extra = {
            selection = 1,
            opitions = {
                [1] = 'tag_charm',
                [2] = 'tag_meteor',
                [5] = 'tag_rare',
                [4] = 'tag_holo',
                [3] = 'tag_foil',
                [6] = 'tag_uncommon',
                [7] = 'tag_polychrome'
            }

        }
    },
    rarity = 1,
    cost = 2,
    blueprint_compat = true,
    eternal_compat = false,
    unlock_card = true,
    discovered = true,
    atlas = 'Jokers',
    pos = { x = 1, y = 1 },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = 'tag_charm', set = 'Tag'}
        info_queue[#info_queue+1] = {key = 'tag_meteor', set = 'Tag'}
        info_queue[#info_queue+1] = {key = 'tag_polychrome', set = 'Tag'}
        info_queue[#info_queue+1] = {key = 'tag_holo', set = 'Tag'}
        info_queue[#info_queue+1] = {key = 'tag_foil', set = 'Tag'}
        info_queue[#info_queue+1] = {key = 'tag_uncommon', set = 'Tag'}
        info_queue[#info_queue+1] = {key = 'tag_rare', set = 'Tag'}
        
        return {vars = {card.ability.extra.selection, card.ability.extra.opitions}}
    end,

    calculate = function(self, card, context)
       if context.selling_self then
            for i=1, 1 do
                G.E_MANAGER:add_event(Event({
                    func = (function()
                        add_tag(Tag(pseudorandom_element(card.ability.extra.opitions, pseudoseed('veg'))))
                        play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                        play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
                        return true
                    end)
                }))
            end
        end
    end
}
SMODS.Joker{
    key = 'Domino_Miku',
    loc_txt = {
        name = 'Domino Miku',
        text = {
            '{C:green}#2# in #3#{} to create a {C:purple}Tarot{} card(s),',
            ' when played {C:attention}hand{} contains a {C:attention}Pair{}',
        }
    },
    config = { extra = { odds = 3 } },
    rarity = 1,
    cost = 4,
    blueprint_compat = true,
    eternal_compat = true,
    unlock_card = true,
    discovered = true,
    atlas = 'Jokers',
    pos = { x = 2, y = 1 },

    loc_vars = function(self, info_queue, card)
        return { vars = {
            card.ability.extra.money,
            (G.GAME.probabilities.normal or 1),
            card.ability.extra.odds
        } }
    end,

    calculate = function(self, card, context)
        if context.poker_hands and next(context.poker_hands['Pair'])
            and not context.repetition
            and not context.blueprint
        then
            -- Check if we can add a new Tarot card
            if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                if pseudorandom('Domino_Miku') < (G.GAME.probabilities.normal or 1) / card.ability.extra.odds then
                    -- Add event for Tarot card creation
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    local new_card = create_card('Tarot', G.consumeables, nil, nil, nil, nil, nil, 'domino')
                                    new_card:add_to_deck()
                                    G.consumeables:emplace(new_card)
                                    G.GAME.consumeable_buffer = 0

                                    -- Display evaluation status message
                                    card_eval_status_text(
                                        context.blueprint_card or new_card,
                                        'extra',
                                        nil,
                                        nil,
                                        nil,
                                        { message = localize('k_plus_tarot'), colour = G.C.PURPLE }
                                    )

                                    return true
                                end
                            }))

                            return true
                        end
                    }))
                end
            end
        end
    end
}
