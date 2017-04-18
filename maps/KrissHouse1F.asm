const_value set 2
	const KRISSHOUSE1F_MOM1
	const KRISSHOUSE1F_MOM2
	const KRISSHOUSE1F_MOM3
	const KRISSHOUSE1F_MOM4
	const KRISSHOUSE1F_POKEFAN_F

KrissHouse1F_MapScriptHeader:
.MapTriggers:
	db 2

	; triggers
	dw .Trigger0, 0
	dw .Trigger1, 0

.MapCallbacks:
	db 0

.Trigger0:
	end

.Trigger1:
	end

MomTrigger1:
	playmusic MUSIC_MOM
	showemote EMOTE_SHOCK, KRISSHOUSE1F_MOM1, 15
	spriteface KRISSHOUSE1F_MOM1, RIGHT
	spriteface PLAYER, LEFT
	jump MomEventScript

MomTrigger2:
	playmusic MUSIC_MOM
	showemote EMOTE_SHOCK, KRISSHOUSE1F_MOM1, 15
	spriteface KRISSHOUSE1F_MOM1, RIGHT
	applymovement PLAYER, KrissHouse1FSlowStepLeftMovementData
	jump MomEventScript

MomTrigger3:
	playmusic MUSIC_MOM
	showemote EMOTE_SHOCK, KRISSHOUSE1F_MOM1, 15
	spriteface KRISSHOUSE1F_MOM1, UP
	applymovement PLAYER, KrissHouse1FSlowStepDownMovementData
MomEventScript:
	opentext
	writetext MomIntroText
	buttonsound
if DEF(DEBUG)
	; full pokegear
	setflag ENGINE_POKEGEAR
	setflag ENGINE_PHONE_CARD
	setflag ENGINE_MAP_CARD
	setflag ENGINE_RADIO_CARD
	setflag ENGINE_EXPN_CARD
	; pokedex
	setflag ENGINE_POKEDEX
	; all hms
	givetmhm HM_CUT
	givetmhm HM_FLY
	givetmhm HM_SURF
	givetmhm HM_STRENGTH
	givetmhm HM_WATERFALL
	givetmhm HM_WHIRLPOOL
	; tms for party
	givetmhm TM_ICE_BEAM
	givetmhm TM_BLIZZARD
	givetmhm TM_FLAMETHROWER
	givetmhm TM_FIRE_BLAST
	givetmhm TM_THUNDERBOLT
	givetmhm TM_THUNDER
	givetmhm TM_PSYCHIC
	givetmhm TM_SHADOW_BALL
	givetmhm TM_EARTHQUAKE
	givetmhm TM_SWORDS_DANCE
	givetmhm TM_CALM_MIND
	givetmhm TM_BULK_UP
	givetmhm TM_ROCK_SMASH
	givetmhm TM_FLASH
	; max money
	givemoney $0, 1000000
	givemoney $0, 1000000
	givemoney $0, 1000000
	givemoney $0, 1000000
	givemoney $0, 1000000
	givemoney $0, 1000000
	givemoney $0, 1000000
	givemoney $0, 1000000
	givemoney $0, 1000000
	givemoney $0, 999999
	giveitem COIN_CASE
	givecoins 50000
	; all badges
	setflag ENGINE_ZEPHYRBADGE
	setflag ENGINE_HIVEBADGE
	setflag ENGINE_PLAINBADGE
	setflag ENGINE_FOGBADGE
	setflag ENGINE_STORMBADGE
	setflag ENGINE_MINERALBADGE
	setflag ENGINE_GLACIERBADGE
	setflag ENGINE_RISINGBADGE
	setflag ENGINE_BOULDERBADGE
	setflag ENGINE_CASCADEBADGE
	setflag ENGINE_THUNDERBADGE
	setflag ENGINE_RAINBOWBADGE
	setflag ENGINE_MARSHBADGE
	setflag ENGINE_SOULBADGE
	setflag ENGINE_VOLCANOBADGE
	setflag ENGINE_EARTHBADGE
	setevent EVENT_BEAT_FALKNER
	setevent EVENT_BEAT_BUGSY
	setevent EVENT_BEAT_WHITNEY
	setevent EVENT_BEAT_MORTY
	setevent EVENT_BEAT_CHUCK
	setevent EVENT_BEAT_JASMINE
	setevent EVENT_BEAT_PRYCE
	setevent EVENT_BEAT_CLAIR
	setevent EVENT_BEAT_BROCK
	setevent EVENT_BEAT_MISTY
	setevent EVENT_BEAT_LTSURGE
	setevent EVENT_BEAT_ERIKA
	setevent EVENT_BEAT_JANINE
	setevent EVENT_BEAT_SABRINA
	setevent EVENT_BEAT_BLAINE
	setevent EVENT_BEAT_BLUE
	setevent EVENT_BEAT_ELITE_FOUR
	setevent EVENT_BEAT_ELITE_FOUR_AGAIN
	; fly anywhere
	setflag ENGINE_FLYPOINT_NEW_BARK
	setflag ENGINE_FLYPOINT_CHERRYGROVE
	setflag ENGINE_FLYPOINT_VIOLET
	setflag ENGINE_FLYPOINT_UNION_CAVE
	setflag ENGINE_FLYPOINT_AZALEA
	setflag ENGINE_FLYPOINT_GOLDENROD
	setflag ENGINE_FLYPOINT_ECRUTEAK
	setflag ENGINE_FLYPOINT_OLIVINE
	setflag ENGINE_FLYPOINT_CIANWOOD
	setflag ENGINE_FLYPOINT_MAHOGANY
	setflag ENGINE_FLYPOINT_LAKE_OF_RAGE
	setflag ENGINE_FLYPOINT_BLACKTHORN
	setflag ENGINE_FLYPOINT_SILVER_CAVE
	setflag ENGINE_FLYPOINT_INDIGO_PLATEAU
	setflag ENGINE_FLYPOINT_PALLET
	setflag ENGINE_FLYPOINT_VIRIDIAN
	setflag ENGINE_FLYPOINT_PEWTER
	setflag ENGINE_FLYPOINT_MT_MOON
	setflag ENGINE_FLYPOINT_CERULEAN
	setflag ENGINE_FLYPOINT_VERMILION
	setflag ENGINE_FLYPOINT_CELADON
	setflag ENGINE_FLYPOINT_ROCK_TUNNEL
	setflag ENGINE_FLYPOINT_LAVENDER
	setflag ENGINE_FLYPOINT_FUCHSIA
	setflag ENGINE_FLYPOINT_SAFFRON
	setflag ENGINE_FLYPOINT_CINNABAR
	; magnet train works
	setevent EVENT_RESTORED_POWER_TO_KANTO
	giveitem PASS
	; cycling road works
	giveitem BICYCLE
	; useful items
	giveitem ITEMFINDER
	giveitem SQUIRTBOTTLE
	giveitem MAX_REPEL, 99
	giveitem MAX_REVIVE, 99
	giveitem FULL_RESTORE, 99
	giveitem MAX_ELIXER, 99
	giveitem RARE_CANDY, 99
	giveitem ESCAPE_ROPE, 99
	giveitem SILVER_LEAF, 99
	giveitem GOLD_LEAF, 99
	giveitem HP_UP, 99
	giveitem PP_UP, 99
	giveitem PROTEIN, 99
	giveitem IRON, 99
	giveitem CARBOS, 99
	giveitem CALCIUM, 99
	giveitem ZINC, 99
	giveitem MASTER_BALL, 99
	callasm SetHallOfFameFlag
	; good party
	givepoke MEWTWO, 100, LEFTOVERS
	givepoke LUGIA, 100, WISE_GLASSES
	givepoke HO_OH, 100, MUSCLE_BAND
	; hm slaves
	givepoke MEW, 100, LEFTOVERS
	givepoke MEW, 100, LEFTOVERS
	; intro events
	addcellnum PHONE_MOM
;	addcellnum PHONE_ELM
;	setevent EVENT_GOT_CYNDAQUIL_FROM_ELM
;	setevent EVENT_CYNDAQUIL_POKEBALL_IN_ELMS_LAB
;	setevent EVENT_CHIKORITA_POKEBALL_IN_ELMS_LAB
;	setevent EVENT_GOT_A_POKEMON_FROM_ELM
;	setevent EVENT_RIVAL_CHERRYGROVE_CITY
;	setevent EVENT_LYRA_IN_ELMS_LAB
;	domaptrigger ELMS_LAB, $5
;	domaptrigger NEW_BARK_TOWN, $2
	dotrigger $1
else
	stringtotext GearName, $1
	callstd receiveitem
	setflag ENGINE_POKEGEAR
	setflag ENGINE_PHONE_CARD
	addcellnum PHONE_MOM
	dotrigger $1
	setevent EVENT_KRISS_HOUSE_MOM_1
	clearevent EVENT_KRISS_HOUSE_MOM_2
	writetext MomPokegearText
	buttonsound
	special Special_SetDayOfWeek
.InitialSetDSTFlag:
	writetext MomDSTText
	yesorno
	iffalse .NotDST
	special Special_InitialSetDSTFlag
	yesorno
	iffalse .InitialSetDSTFlag
	jump .InitializedDSTFlag

.NotDST:
	special Special_InitialClearDSTFlag
	yesorno
	iffalse .InitialSetDSTFlag
.InitializedDSTFlag:
	writetext MomRunningShoesText
	yesorno
	iftrue .NoInstructions
	writetext MomInstructionsText
	buttonsound
.NoInstructions:
	writetext MomOutroText
	waitbutton
endc
	closetext
	spriteface KRISSHOUSE1F_MOM1, LEFT
	special RestartMapMusic
	end

if DEF(DEBUG)
SetHallOfFameFlag:
	; Enable the Pokégear map to cycle through all of Kanto
	ld hl, StatusFlags
	set 6, [hl] ; hall of fame
	ret
else
GearName:
	db "#gear@"
endc

MomScript:
	faceplayer
	checktriggers
	iffalse .MomEvent
	opentext
	checkevent EVENT_FIRST_TIME_BANKING_WITH_MOM
	iftrue .DoIt
	checkevent EVENT_TALKED_TO_MOM_AFTER_MYSTERY_EGG_QUEST
	iftrue .BankOfMom
	checkevent EVENT_GAVE_MYSTERY_EGG_TO_ELM
	iftrue .FirstTimeBanking
	checkevent EVENT_GOT_A_POKEMON_FROM_ELM
	iftrue .Errand
	writetext MomHurryUpText
	waitbutton
	closetext
	end

.Errand:
	writetext MomErrandText
	waitbutton
	closetext
	end

.DoIt:
	writetext MomDoItText
	waitbutton
	closetext
	end

.FirstTimeBanking:
	setevent EVENT_FIRST_TIME_BANKING_WITH_MOM
.BankOfMom:
	setevent EVENT_TALKED_TO_MOM_AFTER_MYSTERY_EGG_QUEST
	special Special_BankOfMom
	waitbutton
	closetext
	end

.MomEvent:
	playmusic MUSIC_MOM
	jump MomEventScript

NeighborScript:
	faceplayer
	opentext
	checkmorn
	iftrue .MornScript
	checkday
	iftrue .DayScript
	checknite
	iftrue .NiteScript

.MornScript:
	writetext NeighborMornIntroText
	buttonsound
	jump .Main

.DayScript:
	writetext NeighborDayIntroText
	buttonsound
	jump .Main

.NiteScript:
	writetext NeighborNiteIntroText
	buttonsound
	jump .Main

.Main:
	writetext NeighborText
	waitbutton
	closetext
	spriteface KRISSHOUSE1F_POKEFAN_F, RIGHT
	end

FridgeScript:
	jumptext FridgeText

SinkScript:
	jumptext SinkText

StoveScript:
	jumptext StoveText

TVScript:
	jumptext TVText

MovementData_0x7a5fc:
	turn_head_right
	step_end

MovementData_0x7a5fe:
	slow_step_right
	step_end

MovementData_0x7a600:
	turn_head_left
	step_end

KrissHouse1FSlowStepLeftMovementData:
	slow_step_left
	step_end

KrissHouse1FSlowStepDownMovementData:
	slow_step_down
	step_end

MomIntroText:
if DEF(DEBUG)
	text "Oh, <PLAYER>!"
	line "Take this debug"
	cont "cheat stuff!"
	done
else
	text "Oh, <PLAYER>!"
	line "You're awake."

	para "Your friend Lyra"
	line "was just here."

	para "She said that our"
	line "neighbor, Prof."

	para "Elm, was looking"
	line "for you."

	para "Oh! I almost for-"
	line "got! Your #mon"

	para "Gear is back from"
	line "the repair shop."

	para "Here you go!"
	done
endc

MomPokegearText:
	text "#mon Gear, or"
	line "just #gear."

	para "It's essential if"
	line "you want to be a"
	cont "good trainer."

	para "Oh, the day of the"
	line "week isn't set."

	para "You mustn't forget"
	line "that!"
	done

MomDSTText:
	text "Is it Daylight"
	line "Saving Time now?"
	done

MomRunningShoesText:
	text "Come home to"
	line "adjust your clock"

	para "for Daylight"
	line "Saving Time."

	para "By the way, do"
	line "you know how to"

	para "use your new"
	line "Running Shoes?"
	done

MomInstructionsText:
	text "I'll read the"
	line "instructions."

	para "Just hold down the"
	line "B Button to run,"
	cont "indoors or out."

	para "Or use the Option"
	line "to always run, and"
	cont "hold B to walk."
	done

MomOutroText:
	text "Gee, aren't they"
	line "convenient?"
	done

MomHurryUpText:
	text "Prof.Elm is wait-"
	line "ing for you."

	para "Hurry up, baby!"
	done

MomErrandText:
	text "So, what was Prof."
	line "Elm's errand?"

	para "…"

	para "That does sound"
	line "challenging."

	para "But, you should be"
	line "proud that people"
	cont "rely on you."
	done

MomDoItText:
	text "<PLAYER>, do it!"

	para "I'm behind you all"
	line "the way!"
	done

NeighborMornIntroText:
	text "Good morning,"
	line "<PLAYER>!"

	para "I'm visiting!"
	done

NeighborDayIntroText:
	text "Hello, <PLAYER>!"
	line "I'm visiting!"
	done

NeighborNiteIntroText:
	text "Good evening,"
	line "<PLAYER>!"

	para "I'm visiting!"
	done

NeighborText:
	text "<PLAYER>, have you"
	line "heard?"

	para "My daughter is"
	line "adamant about"

	para "becoming Prof."
	line "Elm's assistant."

	para "She really loves"
	line "#mon!"
	done

FridgeText:
	text "Let's see what's"
	line "in the fridge…"

	para "Fresh Water and"
	line "tasty Lemonade!"
	done

SinkText:
	text "The sink is spot-"
	line "less. Mom likes it"
	cont "clean."
	done

StoveText:
	text "Mom's specialty!"

	para "Cinnabar Volcano"
	line "Burger!"
	done

TVText:
	text "There's a movie on"
	line "TV: Stars dot the"

	para "sky as two boys"
	line "ride on a train…"

	para "I'd better get"
	line "rolling too!"
	done

KrissHouse1F_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 3
	warp_def $7, $6, 2, NEW_BARK_TOWN
	warp_def $7, $7, 2, NEW_BARK_TOWN
	warp_def $0, $9, 1, KRISS_HOUSE_2F

.XYTriggers:
	db 3
	xy_trigger 0, $4, $8, $0, MomTrigger1, $0, $0
	xy_trigger 0, $4, $9, $0, MomTrigger2, $0, $0
	xy_trigger 0, $2, $7, $0, MomTrigger3, $0, $0

.Signposts:
	db 4
	signpost 1, 0, SIGNPOST_READ, FridgeScript
	signpost 1, 1, SIGNPOST_READ, SinkScript
	signpost 1, 2, SIGNPOST_READ, StoveScript
	signpost 1, 7, SIGNPOST_READ, TVScript

.PersonEvents:
	db 5
	person_event SPRITE_MOM, 4, 7, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, MomScript, EVENT_KRISS_HOUSE_MOM_1
	person_event SPRITE_MOM, 2, 2, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, (1 << MORN), 0, PERSONTYPE_SCRIPT, 0, MomScript, EVENT_KRISS_HOUSE_MOM_2
	person_event SPRITE_MOM, 4, 7, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, (1 << DAY), 0, PERSONTYPE_SCRIPT, 0, MomScript, EVENT_KRISS_HOUSE_MOM_2
	person_event SPRITE_MOM, 2, 0, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, (1 << NITE), 0, PERSONTYPE_SCRIPT, 0, MomScript, EVENT_KRISS_HOUSE_MOM_2
	person_event SPRITE_POKEFAN_F, 4, 4, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, NeighborScript, EVENT_KRISS_HOUSE_1F_NEIGHBOR
