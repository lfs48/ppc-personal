	db MEW ; 151

	db 100, 100, 100, 100, 100, 100
	;   hp  atk  def  spd  sat  sdf

	db PSYCHIC, PSYCHIC
	db 45 ; catch rate
	db 64 ; base exp
	db LUM_BERRY ; item 1
	db LUM_BERRY ; item 2
	db GENDERLESS ; gender
	db 120 ; step cycles to hatch
	dn 5, 5 ; frontpic dimensions
	db SYNCHRONIZE ; ability 1
	db SYNCHRONIZE ; ability 2
if DEF(FAITHFUL)
	db SYNCHRONIZE ; hidden ability
else
	db MAGIC_GUARD ; hidden ability
endc
	db MEDIUM_SLOW ; growth rate
	dn NO_EGGS, NO_EGGS ; egg groups

	; ev_yield
	ev_yield   3,   0,   0,   0,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm DYNAMICPUNCH, DRAGON_CLAW, CURSE, CALM_MIND, ROAR, TOXIC, HAIL, BULK_UP, SWORDS_DANCE, HIDDEN_POWER, SUNNY_DAY, HONE_CLAWS, ICE_BEAM, BLIZZARD, HYPER_BEAM, LIGHT_SCREEN, PROTECT, RAIN_DANCE, GIGA_DRAIN, SAFEGUARD, DRAGONBREATH, SOLAR_BEAM, IRON_TAIL, THUNDERBOLT, THUNDER, EARTHQUAKE, RETURN, DIG, PSYCHIC, SHADOW_BALL, MUD_SLAP, DOUBLE_TEAM, REFLECT, FLASH_CANNON, FLAMETHROWER, SLUDGE_BOMB, SANDSTORM, FIRE_BLAST, SWIFT, AERIAL_ACE, STONE_EDGE, FACADE, WILD_CHARGE, REST, ATTRACT, THIEF, STEEL_WING, ROCK_SLIDE, FURY_CUTTER, ROCK_SMASH, LEECH_LIFE, FOCUS_BLAST, ENERGY_BALL, FALSE_SWIPE, SCALD, X_SCISSOR, DARK_PULSE, ENDURE, DRAGON_PULSE, DAZZLINGLEAM, WILL_O_WISP, ACROBATICS, THUNDER_WAVE, EXPLOSION, SHADOW_CLAW, POISON_JAB, AVALANCHE, GIGA_IMPACT, U_TURN, FLASH, CUT, FLY, SURF, STRENGTH, WATERFALL, WHIRLPOOL, AQUA_TAIL, BODY_SLAM, COUNTER, DEFENSE_CURL, DOUBLE_EDGE, DREAM_EATER, EARTH_POWER, FIRE_PUNCH, HEADBUTT, HYPER_VOICE, ICE_PUNCH, ICY_WIND, IRON_HEAD, PAY_DAY, ROLLOUT, SEED_BOMB, SEISMIC_TOSS, SLEEP_TALK, SUBSTITUTE, SUCKER_PUNCH, SWAGGER, THUNDERPUNCH, VOLT_SWITCH, WATER_PULSE, ZAP_CANNON, ZEN_HEADBUTT
	; end
