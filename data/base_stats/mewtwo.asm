	db MEWTWO ; 150

	db 106, 110,  90, 130, 154,  90
	;   hp  atk  def  spd  sat  sdf

	db PSYCHIC, PSYCHIC
	db 3 ; catch rate
	db 220 ; base exp
	db LEPPA_BERRY ; item 1
	db LEPPA_BERRY ; item 2
	db GENDERLESS ; gender
	db 120 ; step cycles to hatch
	dn 7, 7 ; frontpic dimensions
	db PRESSURE ; ability 1
	db INSOMNIA ; ability 2
	db UNNERVE ; hidden ability
	db SLOW ; growth rate
	dn NO_EGGS, NO_EGGS ; egg groups

	; ev_yield
	ev_yield   0,   0,   0,   0,   3,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm DYNAMICPUNCH, CURSE, CALM_MIND, TOXIC, HAIL, BULK_UP, HIDDEN_POWER, SUNNY_DAY, ICE_BEAM, BLIZZARD, HYPER_BEAM, LIGHT_SCREEN, PROTECT, RAIN_DANCE, SAFEGUARD, SOLAR_BEAM, IRON_TAIL, THUNDERBOLT, THUNDER, EARTHQUAKE, RETURN, PSYCHIC, SHADOW_BALL, MUD_SLAP, DOUBLE_TEAM, REFLECT, FLAMETHROWER, SANDSTORM, FIRE_BLAST, SWIFT, AERIAL_ACE, STONE_EDGE, FACADE, REST, ROCK_SLIDE, ROCK_SMASH, FOCUS_BLAST, ENERGY_BALL, ENDURE, WILL_O_WISP, THUNDER_WAVE, POISON_JAB, AVALANCHE, GIGA_IMPACT, FLASH, STRENGTH, AQUA_TAIL, BODY_SLAM, COUNTER, DOUBLE_EDGE, DREAM_EATER, FIRE_PUNCH, HEADBUTT, ICE_PUNCH, ICY_WIND, PAY_DAY, SEISMIC_TOSS, SLEEP_TALK, SUBSTITUTE, SWAGGER, THUNDERPUNCH, WATER_PULSE, ZAP_CANNON, ZEN_HEADBUTT
	; end
