	db  10,  55,  30,  90,  35,  45 ; 265 BST
	;   hp  atk  def  spd  sat  sdf

	db GROUND, STEEL
	db 255 ; catch rate
	db 81 ; base exp
	db NO_ITEM ; item 1
	db SOFT_SAND ; item 2
	dn FEMALE_50, 3 ; gender, step cycles to hatch
	INCBIN "gfx/pokemon/diglett_alolan/front.dimensions"
	abilities_for DIGLETT_ALOLAN, SAND_VEIL, TANGLING_HAIR, SAND_FORCE
	db MEDIUM_FAST ; growth rate
	dn FIELD, FIELD ; egg groups

	ev_yield   0,   0,   0,   1,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, TOXIC, HIDDEN_POWER, SUNNY_DAY, HONE_CLAWS, PROTECT, BULLDOZE, EARTHQUAKE, RETURN, DIG, ROCK_SMASH, DOUBLE_TEAM, FLASH_CANNON, SLUDGE_BOMB, SANDSTORM, AERIAL_ACE, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, ROCK_SLIDE, SHADOW_CLAW, CUT, AGILITY, BODY_SLAM, DOUBLE_EDGE, EARTH_POWER, ENDURE, HEADBUTT, IRON_HEAD, SLEEP_TALK, SUCKER_PUNCH, SWAGGER
	; end
