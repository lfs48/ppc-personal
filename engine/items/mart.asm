	const_def
	const MARTTEXT_HOW_MANY
	const MARTTEXT_COSTS_THIS_MUCH
	const MARTTEXT_NOT_ENOUGH_MONEY
	const MARTTEXT_BAG_FULL
	const MARTTEXT_HERE_YOU_GO
	const MARTTEXT_SOLD_OUT

OpenMartDialog::
	ld a, c
	ld [wEngineBuffer1], a
	call GetMart
	call LoadMartPointer
	ld a, [wEngineBuffer1]
	ld hl, .dialogs
	call JumpTable
	ret

.dialogs
	dw MartDialog
	dw HerbShop
	dw BargainShop
	dw Pharmacist
	dw RooftopSale
	dw SilphMart
	dw AdventurerMart
	dw InformalMart
	dw BazaarMart
	dw TMMart
	dw BlueCardMart
	dw BTMart

MartDialog:
	xor a
	ld [wEngineBuffer1], a
	ld [wEngineBuffer5], a
	jp StandardMart

HerbShop:
	call FarReadMart
	call LoadStandardMenuDataHeader
	ld hl, Text_HerbShop_Intro
	call MartTextBox
	call BuyMenu
	ld hl, Text_HerbShop_ComeAgain
	jp MartTextBox

BargainShop:
	ld b, BANK(BargainShopData)
	ld de, BargainShopData
	call LoadMartPointer
	call ReadMart
	call LoadStandardMenuDataHeader
	ld hl, Text_BargainShop_Intro
	call MartTextBox
	call BuyMenu
	ld hl, wBargainShopFlags
	ld a, [hli]
	or [hl]
	jr z, .skip_set
	ld hl, wDailyFlags ; ENGINE_GOLDENROD_UNDERGROUND_MERCHANT_CLOSED
	set 6, [hl]

.skip_set
	ld hl, Text_BargainShop_ComeAgain
	jp MartTextBox

INCLUDE "data/items/bargain_shop.asm"

Pharmacist:
	call FarReadMart
	call LoadStandardMenuDataHeader
	ld hl, Text_Pharmacist_Intro
	call MartTextBox
	call BuyMenu
	ld hl, Text_Pharmacist_ComeAgain
	jp MartTextBox

RooftopSale:
	ld b, BANK(RooftopSaleData1) ; BANK(RooftopSaleData2)
	ld de, RooftopSaleData1
	ld hl, wStatusFlags
	bit 6, [hl] ; hall of fame
	jr z, .ok
	ld de, RooftopSaleData2
.ok
	call LoadMartPointer
	call ReadMart
	call LoadStandardMenuDataHeader
	ld hl, Text_Mart_HowMayIHelpYou
	call MartTextBox
	call BuyMenu
	ld hl, Text_Mart_ComeAgain
	jp MartTextBox

INCLUDE "data/items/rooftop_sale.asm"

SilphMart:
	call FarReadMart
	call LoadStandardMenuDataHeader
	ld hl, Text_SilphMart_Intro
	call MartTextBox
	call BuyMenu
	ld hl, Text_SilphMart_ComeAgain
	jp MartTextBox

AdventurerMart:
	call FarReadMart
	call LoadStandardMenuDataHeader
	ld hl, Text_AdventurerMart_Intro
	call MartTextBox
	call BuyMenu
	ld hl, Text_AdventurerMart_ComeAgain
	jp MartTextBox

InformalMart:
	call FarReadMart
	call LoadStandardMenuDataHeader
	ld hl, Text_InformalMart_Intro
	call MartTextBox
	call BuyMenu
	ld hl, Text_InformalMart_ComeAgain
	jp MartTextBox

BazaarMart:
	call FarReadMart
	call LoadStandardMenuDataHeader
	ld hl, Text_BazaarMart_Intro
	call MartTextBox
	call BuyMenu
	ld hl, Text_BazaarMart_ComeAgain
	jp MartTextBox

TMMart:
	call FarReadTMMart
	call LoadStandardMenuDataHeader
	ld hl, Text_Mart_HowMayIHelpYou
	call MartTextBox
	call BuyTMMenu
	ld hl, Text_Mart_ComeAgain
	jp MartTextBox

BlueCardMart:
	ld b, BANK(BlueCardMartData)
	ld de, BlueCardMartData
	call LoadMartPointer
	call ReadBlueCardMart
	call LoadStandardMenuDataHeader
	ld hl, Text_BlueCardMart_HowMayIHelpYou
	call MartTextBox
	call BlueCardBuyMenu
	ld hl, Text_BlueCardMart_ComeAgain
	jp MartTextBox

INCLUDE "data/items/buena_prizes.asm"

BTMart:
	call FarReadBTMart
	call LoadStandardMenuDataHeader
	ld hl, Text_BTMart_HowMayIHelpYou
	call MartTextBox
	call BTBuyMenu
	ld hl, Text_BTMart_ComeAgain
	jp MartTextBox

LoadMartPointer:
	ld a, b
	ld [wMartPointerBank], a
	ld a, e
	ld [wMartPointer], a
	ld a, d
	ld [wMartPointer + 1], a
	ld hl, wCurMart
	xor a
	ld bc, wCurMartEnd - wCurMart
	rst ByteFill
	xor a
	ld [wEngineBuffer5], a
	ld [wBargainShopFlags], a
	ld [wFacingDirection], a
	ret

GetMart:
	ld hl, Marts
	add hl, de
	add hl, de
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld b, BANK(Marts)
	ret

StandardMart:
.loop
	ld a, [wEngineBuffer5]
	ld hl, .MartFunctions
	call JumpTable
	ld [wEngineBuffer5], a
	cp $ff
	jr nz, .loop
	ret

.MartFunctions:
	dw .HowMayIHelpYou
	dw .TopMenu
	dw .Buy
	dw .Sell
	dw .Quit
	dw .AnythingElse

.HowMayIHelpYou:
	call LoadStandardMenuDataHeader
	ld hl, Text_Mart_HowMayIHelpYou
	call PrintText
	ld a, $1 ; top menu
	ret

.TopMenu:
	ld hl, MenuDataHeader_BuySell
	call CopyMenuDataHeader
	call VerticalMenu
	jr c, .quit
	ld a, [wMenuCursorY]
	cp $1
	jr z, .buy
	cp $2
	jr z, .sell
.quit
	ld a, $4 ;  Come again!
	ret
.buy
	ld a, $2 ; buy
	ret
.sell
	ld a, $3 ; sell
	ret

.Buy:
	call ExitMenu
	call FarReadMart
	call BuyMenu
	and a
	ld a, $5 ; Anything else?
	ret

.Sell:
	call ExitMenu
	call SellMenu
	ld a, $5 ; Anything else?
	ret

.Quit:
	call ExitMenu
	ld hl, Text_Mart_ComeAgain
	call MartTextBox
	ld a, $ff ; exit
	ret

.AnythingElse:
	call LoadStandardMenuDataHeader
	ld hl, Text_Mart_AnythingElse
	call PrintText
	ld a, $1 ; top menu
	ret

FarReadMart:
	ld hl, wMartPointer
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, wCurMart
.CopyMart:
	ld a, [wMartPointerBank]
	call GetFarByte
	ld [de], a
	inc hl
	inc de
	cp -1
	jr nz, .CopyMart
	ld hl, wMartItem1BCD
	ld de, wCurMart + 1
.ReadMartItem:
	ld a, [de]
	inc de
	cp -1
	ret z
	push de
	call GetMartItemPrice
	pop de
	jr .ReadMartItem

; FarReadTMMart needs to use GetFarByte from wMartPointerBank.
; ReadMart could just load from hl directly.
; But their structures are identical, so here they both use GetFarByte.
FarReadTMMart:
ReadMart:
; Load the mart pointer.  Mart data is local (no need for bank).
	ld hl, wMartPointer
	ld a, [hli]
	ld h, [hl]
	ld l, a
	push hl
; set hl to the first item
	inc hl
	ld bc, wMartItem1BCD
	ld de, wCurMart + 1
.loop
; copy the item to wCurMart + (ItemIndex)
	ld a, [wMartPointerBank]
	call GetFarByte
	inc hl
	ld [de], a
	inc de
; -1 is the terminator
	cp -1
	jr z, .done

	push de
; copy the price to de
	ld a, [wMartPointerBank]
	call GetFarByte
	inc hl
	ld e, a
	ld a, [wMartPointerBank]
	call GetFarByte
	inc hl
	ld d, a
; convert the price to 3-byte BCD at [bc]
	push hl
	ld h, b
	ld l, c
	call GetMartPrice
	ld b, h
	ld c, l
	pop hl

	pop de
	jr .loop

.done
	pop hl
	ld a, [wMartPointerBank]
	call GetFarByte
	ld [wCurMart], a
	ret

; FarReadBTMart needs to use GetFarByte from wMartPointerBank.
; ReadBlueCardMart could just load from hl directly.
; But their structures are identical, so here they both use GetFarByte.
FarReadBTMart:
ReadBlueCardMart:
; Load the mart pointer.  Mart data is local (no need for bank).
	ld hl, wMartPointer
	ld a, [hli]
	ld h, [hl]
	ld l, a
	push hl
; set hl to the first item
	inc hl
	ld bc, wMartItem1BCD
	ld de, wCurMart + 1
.loop
; copy the item to wCurMart + (ItemIndex)
	ld a, [wMartPointerBank]
	call GetFarByte
	inc hl
	ld [de], a
	inc de
; -1 is the terminator
	cp -1
	jr z, .done

; copy the point cost to [bc]
	ld a, [wMartPointerBank]
	call GetFarByte
	inc hl
	ld [bc], a

	inc bc
	jr .loop

.done
	pop hl
	ld a, [wMartPointerBank]
	call GetFarByte
	ld [wCurMart], a
	ret

GetMartItemPrice:
; Return the price of item a in BCD at hl and in tiles at wStringBuffer1.
	push hl
	ld [wCurItem], a
	farcall GetItemPrice
	pop hl

GetMartPrice:
; Return price de in BCD at hl and in tiles at wStringBuffer1.
	push hl
	ld a, d
	ld [wStringBuffer2], a
	ld a, e
	ld [wStringBuffer2 + 1], a
	ld hl, wStringBuffer1
	ld de, wStringBuffer2
	lb bc, PRINTNUM_LEADINGZEROS | 2, 6 ; 6 digits
	call PrintNum
	pop hl

	ld de, wStringBuffer1
	ld c, 6 / 2 ; 6 digits
.loop
	call .CharToNybble
	swap a
	ld b, a
	call .CharToNybble
	or b
	ld [hli], a
	dec c
	jr nz, .loop
	ret

.CharToNybble:
	ld a, [de]
	inc de
	cp " "
	jr nz, .not_space
	ld a, "0"

.not_space
	sub "0"
	ret

BuyMenu:
	call BuyMenu_InitGFX
.loop
	call BuyMenuLoop ; menu loop
	jr nc, .loop
BuyMenu_Finish:
	call SFXDelay2
	call ReturnToMapWithSpeechTextbox
	and a
	ret

BuyTMMenu:
	call BuyMenu_InitGFX
.loop
	call BuyTMMenuLoop ; menu loop
	jr nc, .loop
	jr BuyMenu_Finish

BlueCardBuyMenu:
	call BuyMenu_InitGFX
.loop
	call BlueCardBuyMenuLoop ; menu loop
	jr nc, .loop
	jr BuyMenu_Finish

BTBuyMenu:
	call BuyMenu_InitGFX
.loop
	call BTBuyMenuLoop ; menu loop
	jr nc, .loop
	jr BuyMenu_Finish

BuyMenu_InitGFX:
	xor a
	ldh [hBGMapMode], a
	farcall FadeOutPalettes
	call ClearBGPalettes
	call ClearTileMap
	call ClearSprites
	call DisableSpriteUpdates
	call DisableLCD
	ld hl, PackLeftColumnGFX
	ld de, vTiles2 tile $15
	ld bc, 18 tiles
	ld a, BANK(PackLeftColumnGFX)
	call FarCopyBytes
; This is where the items themselves will be listed.
;	hlcoord 5, 3
;	lb bc, 9, 15
;	call ClearBox
; Place the text box for bag quantity
	hlcoord 0, 0
	lb bc, 1, 8
	call TextBox
; Place the left column
	hlcoord 0, 3
	ld de, .BuyLeftColumnTilemapString
	ld bc, SCREEN_WIDTH - 5
.loop
	ld a, [de]
	and a
	jr nz, .continue
	add hl, bc
	jr .next
.continue
	cp $ff
	jr z, .ok
	ld [hli], a
.next
	inc de
	jr .loop
.ok
; Place the textbox for displaying the item description
;	hlcoord 0, SCREEN_HEIGHT - 4 - 2
;	lb bc, 4, SCREEN_WIDTH - 2
;	call TextBox
	call EnableLCD
	call ApplyTilemapInVBlank
	ld a, CGB_BUYMENU_PALS
	call GetCGBLayout
	call SetPalettes
; Not graphics-related, but common to all BuyMenu_InitGFX callers
	xor a
	ld [wMenuScrollPositionBackup], a
	ld a, 1
	ld [wMenuCursorBufferBackup], a
	jp DelayFrame

.BuyLeftColumnTilemapString:
	db $15, $15, $15, $15, $15, 0
	db $15, $15, $15, $15, $15, 0
	db $15, $15, $15, $15, $15, 0
	db $15, $15, $15, $15, $15, 0
	db $16, $17, $17, $17, $18, 0
	db $19, $1e, $1f, $20, $1a, 0
	db $19, $21, $22, $23, $1a, 0
	db $19, $24, $25, $26, $1a, 0
	db $1b, $1c, $1c, $1c, $1d, -1

LoadBuyMenuText:
; load text from a nested table
; which table is in wEngineBuffer1
; which entry is in register a
	push af
	call GetMartDialogGroup ; gets a pointer from GetMartDialogGroup.MartTextFunctionPointers
	ld a, [hli]
	ld h, [hl]
	ld l, a
	pop af
	ld e, a
	ld d, 0
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp PrintText

MartAskPurchaseQuantity:
	ld a, [wCurItem]
	call GetMartDialogGroup ; gets a pointer from GetMartDialogGroup.MartTextFunctionPointers
	inc hl
	inc hl
	ld a, [hl]
	and a
	jp z, StandardMartAskPurchaseQuantity
	cp 1
	jp z, BargainShopAskPurchaseQuantity
	jp RooftopSaleAskPurchaseQuantity

GetMartDialogGroup:
	ld a, [wEngineBuffer1]
	ld e, a
	ld d, 0
	ld hl, .MartTextFunctionPointers
	add hl, de
	add hl, de
	add hl, de
	ret

.MartTextFunctionPointers:
	dwb .StandardMartPointers, 0
	dwb .HerbShopPointers, 0
	dwb .BargainShopPointers, 1
	dwb .PharmacyPointers, 0
	dwb .StandardMartPointers, 2
	dwb .SilphMartPointers, 0
	dwb .AdventurerMartPointers, 0
	dwb .InformalMartPointers, 0
	dwb .BazaarMartPointers, 0
	dwb .TMMartPointers, 0
	dwb .BlueCardMartPointers, 0
	dwb .BTMartPointers, 0

.StandardMartPointers:
	dw Text_Mart_HowMany
	dw Text_Mart_CostsThisMuch
	dw Text_Mart_InsufficientFunds
	dw Text_Mart_BagFull
	dw Text_Mart_HereYouGo
	dw BuyMenuLoop

.HerbShopPointers:
	dw Text_HerbShop_HowMany
	dw Text_HerbShop_CostsThisMuch
	dw Text_HerbShop_InsufficientFunds
	dw Text_HerbShop_BagFull
	dw Text_HerbShop_HereYouGo
	dw BuyMenuLoop

.BargainShopPointers:
	dw BuyMenuLoop
	dw Text_BargainShop_CostsThisMuch
	dw Text_BargainShop_InsufficientFunds
	dw Text_BargainShop_BagFull
	dw Text_BargainShop_HereYouGo
	dw Text_BargainShop_SoldOut

.PharmacyPointers:
	dw Text_Pharmacy_HowMany
	dw Text_Pharmacy_CostsThisMuch
	dw Text_Pharmacy_InsufficientFunds
	dw Text_Pharmacy_BagFull
	dw Text_Pharmacy_HereYouGo
	dw BuyMenuLoop

.SilphMartPointers:
	dw Text_SilphMart_HowMany
	dw Text_SilphMart_CostsThisMuch
	dw Text_SilphMart_InsufficientFunds
	dw Text_SilphMart_BagFull
	dw Text_SilphMart_HereYouGo
	dw BuyMenuLoop

.AdventurerMartPointers:
	dw Text_AdventurerMart_HowMany
	dw Text_AdventurerMart_CostsThisMuch
	dw Text_AdventurerMart_InsufficientFunds
	dw Text_AdventurerMart_BagFull
	dw Text_AdventurerMart_HereYouGo
	dw BuyMenuLoop

.InformalMartPointers:
	dw Text_InformalMart_HowMany
	dw Text_InformalMart_CostsThisMuch
	dw Text_InformalMart_InsufficientFunds
	dw Text_InformalMart_BagFull
	dw Text_InformalMart_HereYouGo
	dw BuyMenuLoop

.BazaarMartPointers:
	dw Text_BazaarMart_HowMany
	dw Text_BazaarMart_CostsThisMuch
	dw Text_BazaarMart_InsufficientFunds
	dw Text_BazaarMart_BagFull
	dw Text_BazaarMart_HereYouGo
	dw BuyMenuLoop

.TMMartPointers:
	dw Text_Mart_HowMany
	dw Text_TMMart_CostsThisMuch
	dw Text_Mart_InsufficientFunds
	dw Text_Mart_BagFull
	dw Text_Mart_HereYouGo
	dw BuyTMMenuLoop

.BlueCardMartPointers:
	dw BlueCardBuyMenuLoop
	dw Text_BlueCardMart_CostsThisMuch
	dw Text_BlueCardMart_InsufficientFunds
	dw Text_BlueCardMart_BagFull
	dw Text_BlueCardMart_HereYouGo
	dw BlueCardBuyMenuLoop

.BTMartPointers:
	dw Text_BTMart_HowMany
	dw Text_BTMart_CostsThisMuch
	dw Text_BTMart_InsufficientFunds
	dw Text_BTMart_BagFull
	dw Text_BTMart_HereYouGo
	dw BlueCardBuyMenuLoop

BuyMenuLoop:
	farcall PlaceMoneyTopRight
	call UpdateSprites
	ld hl, MenuDataHeader_Buy
	call CopyMenuDataHeader
	call DoMartScrollingMenu
	call SpeechTextBox
	ld a, [wMenuJoypad]
	cp B_BUTTON
	jp z, MartMenuLoop_SetCarry
	call MartAskPurchaseQuantity
	jr c, .cancel
	call MartConfirmPurchase
	jr c, .cancel
	ld de, wMoney
	ld bc, hMoneyTemp
	call CompareMoney
	jp c, MartMenuLoop_InsufficientFunds
	ld hl, wNumItems
	call ReceiveItem
	jp nc, MartMenuLoop_InsufficientBagSpace
	ld a, [wMartItemID]
	ld e, a
	ld d, $0
	ld b, SET_FLAG
	ld hl, wBargainShopFlags
	call FlagAction
	call PlayTransactionSound
	ld de, wMoney
	ld bc, hMoneyTemp
	call TakeMoney
	ld a, MARTTEXT_HERE_YOU_GO
	call LoadBuyMenuText
	call JoyWaitAorB
	farcall CheckItemPocket
	ld a, [wItemAttributeParamBuffer]
	cp BALL
	jr nz, .cancel
	ld a, [wItemQuantityChangeBuffer]
	cp 10
	jr c, .cancel
	ld a, PREMIER_BALL
	ld [wCurItem], a
	ld a, [wItemQuantityChangeBuffer]
	ld c, 10
	call SimpleDivide
	ld a, b
	ld [wItemQuantityChangeBuffer], a
	ld hl, wNumItems
	call ReceiveItem
	jr nc, .cancel
	ld hl, .PremierBallText
	call PrintText
	call JoyWaitAorB
.cancel
	call SpeechTextBox
	and a
	ret

.PremierBallText
	text_jump MartPremierBallText
	db "@"

BuyTMMenuLoop:
	farcall PlaceMoneyTopRight
	call UpdateSprites
	ld hl, TMMenuDataHeader_Buy
	call CopyMenuDataHeader
	call DoMartScrollingMenu
	call SpeechTextBox
	ld a, [wMenuJoypad]
	cp B_BUTTON
	jp z, MartMenuLoop_SetCarry
	call TMMartAskPurchaseQuantity
	jr c, .cancel
	call TMMartConfirmPurchase
	jr c, .cancel
	ld de, wMoney
	ld bc, hMoneyTemp
	call CompareMoney
	jp c, MartMenuLoop_InsufficientFunds
	call ReceiveTMHM
	call PlayTransactionSound
	ld de, wMoney
	ld bc, hMoneyTemp
	call TakeMoney
	ld a, MARTTEXT_HERE_YOU_GO
	call LoadBuyMenuText
	call JoyWaitAorB
.cancel
	call SpeechTextBox
	and a
	ret

BlueCardBuyMenuLoop:
	farcall PlaceBlueCardPointsTopRight
	call UpdateSprites
	ld hl, BlueCardMenuDataHeader_Buy
	call CopyMenuDataHeader
	call DoMartScrollingMenu
	call SpeechTextBox
	ld a, [wMenuJoypad]
	cp B_BUTTON
	jp z, MartMenuLoop_SetCarry
	call MartConfirmPurchase
	jr c, .cancel
	call BlueCardMartComparePoints
	jp c, MartMenuLoop_InsufficientFunds
	ld hl, wNumItems
	call ReceiveItem
	jp nc, MartMenuLoop_InsufficientBagSpace
	call PlayTransactionSound
	ld a, [wBlueCardBalance]
	ld hl, hMoneyTemp
	sub [hl]
	ld [wBlueCardBalance], a
	ld a, MARTTEXT_HERE_YOU_GO
	call LoadBuyMenuText
	call JoyWaitAorB
.cancel
	call SpeechTextBox
	and a
	ret

BTBuyMenuLoop:
	farcall PlaceBattlePointsTopRight
	call UpdateSprites
	ld hl, BTMenuDataHeader_Buy
	call CopyMenuDataHeader
	call DoMartScrollingMenu
	call SpeechTextBox
	ld a, [wMenuJoypad]
	cp B_BUTTON
	jp z, MartMenuLoop_SetCarry
	call BTMartAskPurchaseQuantity
	jr c, .cancel
	call BTMartConfirmPurchase
	jr c, .cancel
	call BTMartCompareBP
	jp c, MartMenuLoop_InsufficientFunds
	ld hl, wNumItems
	call ReceiveItem
	jp nc, MartMenuLoop_InsufficientBagSpace
	call PlayTransactionSound
	ld a, [wBattlePoints]
	ld hl, hMoneyTemp + 2
	sub [hl]
	ld [wBattlePoints], a
	ld a, MARTTEXT_HERE_YOU_GO
	call LoadBuyMenuText
	call JoyWaitAorB
.cancel
	call SpeechTextBox
	and a
	ret

DoMartScrollingMenu:
	ld a, [wMenuCursorBufferBackup]
	ld [wMenuCursorBuffer], a
	ld a, [wMenuScrollPositionBackup]
	ld [wMenuScrollPosition], a
	call ScrollingMenu
	ld a, [wMenuScrollPosition]
	ld [wMenuScrollPositionBackup], a
	ld a, [wMenuCursorY]
	ld [wMenuCursorBufferBackup], a
	ret

MartMenuLoop_InsufficientBagSpace:
	ld a, MARTTEXT_BAG_FULL
	jr MartMenuLoop_Continue

MartMenuLoop_InsufficientFunds:
	ld a, MARTTEXT_NOT_ENOUGH_MONEY
MartMenuLoop_Continue:
	call LoadBuyMenuText
	call JoyWaitAorB
	and a
	ret

MartMenuLoop_SetCarry:
	scf
	ret

StandardMartAskPurchaseQuantity:
	ld a, MARTTEXT_HOW_MANY
	call LoadBuyMenuText
	farcall SelectQuantityToBuy
	jp ExitMenu

MartConfirmPurchase:
BTMartConfirmPurchase:
	predef PartyMonItemName
	ld a, MARTTEXT_COSTS_THIS_MUCH
	call LoadBuyMenuText
	jp YesNoBox

TMMartConfirmPurchase:
	ld a, [wCurTMHM]
	ld [wd265], a
	call GetTMHMName
	call CopyName1

	; off by one error?
	ld a, [wd265]
	inc a
	ld [wd265], a

	predef GetTMHMMove
	ld a, [wd265]
	ld [wPutativeTMHMMove], a
	call GetMoveName

	ld a, MARTTEXT_COSTS_THIS_MUCH
	call LoadBuyMenuText
	jp YesNoBox

BargainShopAskPurchaseQuantity:
	ld a, 1
	ld [wItemQuantityChangeBuffer], a
	ld a, [wMartItemID]
	ld e, a
	ld d, $0
	ld b, CHECK_FLAG
	ld hl, wBargainShopFlags
	call FlagAction
	ld a, c
	and a
	jr nz, .SoldOut
	ld a, [wMartItemID]
	ld e, a
	ld d, $0
	ld hl, wMartPointer
	ld a, [hli]
	ld h, [hl]
	ld l, a
	inc hl
	add hl, de
	add hl, de
	add hl, de
	inc hl
	ld a, [hli]
	ldh [hMoneyTemp + 2], a
	ld a, [hl]
	ldh [hMoneyTemp + 1], a
	xor a
	ldh [hMoneyTemp], a
	and a
	ret

.SoldOut:
	ld a, MARTTEXT_SOLD_OUT
	call LoadBuyMenuText
	call JoyWaitAorB
	scf
	ret

RooftopSaleAskPurchaseQuantity:
	ld a, MARTTEXT_HOW_MANY
	call LoadBuyMenuText
	call .GetSalePrice
	farcall RooftopSale_SelectQuantityToBuy
	jp ExitMenu

.GetSalePrice:
	ld a, [wMartItemID]
	ld e, a
	ld d, 0
	ld hl, wMartPointer
	ld a, [hli]
	ld h, [hl]
	ld l, a
	inc hl
	add hl, de
	add hl, de
	add hl, de
	inc hl
	ld e, [hl]
	inc hl
	ld d, [hl]
	ret

TMMartAskPurchaseQuantity:
	ld a, [wCurTMHM]
	call CheckTMHM
	jr c, .AlreadyHaveTM

	ld a, 1
	ld [wItemQuantityChangeBuffer], a
	ld a, [wMartItemID]
	ld e, a
	ld d, $0
	ld hl, wMartPointer
	ld a, [hli]
	ld h, [hl]
	ld l, a
	inc hl
	add hl, de
	add hl, de
	add hl, de
	inc hl
	ld a, [hli]
	ldh [hMoneyTemp + 2], a
	ld a, [hl]
	ldh [hMoneyTemp + 1], a
	xor a
	ldh [hMoneyTemp], a
	and a
	ret

.AlreadyHaveTM
	ld hl, .AlreadyHaveTMText
	call PrintText
	call JoyWaitAorB
	scf
	ret

.AlreadyHaveTMText
	text_jump AlreadyHaveTMText
	db "@"

BTMartAskPurchaseQuantity:
	ld a, MARTTEXT_HOW_MANY
	call LoadBuyMenuText
; store point cost in c
	ld a, [wMartItemID]
	ld e, a
	ld d, $0
	ld hl, wMartPointer
	ld a, [hli]
	ld h, [hl]
	ld l, a
	inc hl
	add hl, de
	add hl, de
	inc hl
	ld a, [hl]
	ld c, a
	ld [wBuffer2], a
	xor a
	ld [wBuffer1], a
; divide BP balance by cost to get maximum quantity
	ld a, [wBattlePoints]
	call SimpleDivide
	ld a, b
	and a
	jr nz, .ok
	ld a, 1
.ok
	ld [wItemQuantityBuffer], a
	farcall BT_SelectQuantityToBuy
	jp ExitMenu

BlueCardMartComparePoints:
; no need for a "BlueCardMartAskPurchaseQuantity"
	ld a, 1
	ld [wItemQuantityChangeBuffer], a
; store point cost in [hMoneyTemp]
	ld a, [wMartItemID]
	ld e, a
	ld d, $0
	ld hl, wMartPointer
	ld a, [hli]
	ld h, [hl]
	ld l, a
	inc hl
	add hl, de
	add hl, de
	inc hl
	ld a, [hl]
	ldh [hMoneyTemp], a
; compare point balance with cost
	ld d, a
	ld a, [wBlueCardBalance]
	cp d
	ret

BTMartCompareBP:
; compare BP balance with cost
	ldh a, [hMoneyTemp + 2]
	ld d, a
	ld a, [wBattlePoints]
	cp d
	ret

Text_Mart_HowMany:
Text_BTMart_HowMany:
	; How many?
	text_jump UnknownText_0x1c4bfd
	db "@"

Text_Mart_CostsThisMuch:
Text_AdventurerMart_CostsThisMuch:
	; @ (S) will be ¥@ .
	text_jump UnknownText_0x1c4c08
	db "@"

MenuDataHeader_Buy:
	db $40 ; flags
	db 03, 06 ; start coords
	db 11, 19 ; end coords
	dw .menudata2
	db 1 ; default option

.menudata2
	db $30 ; pointers
	db 4, 8 ; rows, columns
	db 1 ; horizontal spacing
	dbw 0, wCurMart
	dba PlaceMartItemName
	dba MartMenu_PrintBCDPrices
	dba UpdateItemIconAndDescriptionAndBagQuantity

TMMenuDataHeader_Buy:
	db $40 ; flags
	db 03, 06 ; start coords
	db 11, 19 ; end coords
	dw .menudata2
	db 1 ; default option

.menudata2
	db $30 ; pointers
	db 4, 8 ; rows, columns
	db 1 ; horizontal spacing
	dbw 0, wCurMart
	dba PlaceMenuTMHMName
	dba MartMenu_PrintBCDPrices
	dba UpdateTMHMIconAndDescriptionAndOwnership

MartMenu_PrintBCDPrices:
	ld a, [wScrollingMenuCursorPosition]
	ld c, a
	ld b, 0
	ld hl, wMartItem1BCD
	add hl, bc
	add hl, bc
	add hl, bc
	call SwapHLDE
	ld bc, SCREEN_WIDTH - 4
	add hl, bc
	ld c, PRINTNUM_LEADINGZEROS | PRINTNUM_MONEY | 3
	jp PrintBCDNumber

BlueCardMenuDataHeader_Buy:
	db $40 ; flags
	db 03, 06 ; start coords
	db 11, 19 ; end coords
	dw .menudata2
	db 1 ; default option

.menudata2
	db $30 ; pointers
	db 4, 8 ; rows, columns
	db 1 ; horizontal spacing
	dbw 0, wCurMart
	dba PlaceMartItemName
	dba .PrintPointCosts
	dba UpdateItemIconAndDescriptionAndBagQuantity

.PrintPointCosts:
	call GetCursorItemPointCost
	ld bc, SCREEN_WIDTH - 4
	add hl, bc
	lb bc, 1, 3
	call PrintNum
	ld de, .PointsString
	jp _PlaceString

.PointsString:
	db " Pts@"

BTMenuDataHeader_Buy:
	db $40 ; flags
	db 03, 06 ; start coords
	db 11, 19 ; end coords
	dw .menudata2
	db 1 ; default option

.menudata2
	db $30 ; pointers
	db 4, 8 ; rows, columns
	db 1 ; horizontal spacing
	dbw 0, wCurMart
	dba PlaceMartItemName
	dba .PrintPointCosts
	dba UpdateItemIconAndDescriptionAndBagQuantity

.PrintPointCosts:
	call GetCursorItemPointCost
	ld bc, SCREEN_WIDTH - 3
	add hl, bc
	lb bc, 1, 3
	call PrintNum
	ld de, .PointsString
	jp _PlaceString

.PointsString:
	db " BP@"

GetCursorItemPointCost:
	ld a, [wScrollingMenuCursorPosition]
	ld c, a
	ld b, 0
	ld hl, wMartItem1BCD
	add hl, bc
	jp SwapHLDE

Text_HerbShop_Intro:
	; Hello, dear. I sell inexpensive herbal medicine. They're good, but a trifle bitter. Your #MON may not like them. Hehehehe…
	text_jump UnknownText_0x1c4c28
	db "@"

Text_HerbShop_CostsThisMuch:
	; @ (S) will be ¥@ .
	text_jump UnknownText_0x1c4cae
	db "@"

Text_HerbShop_HereYouGo:
	; Thank you, dear. Hehehehe…
	text_jump UnknownText_0x1c4cce
	db "@"

Text_HerbShop_BagFull:
	; Oh? Your PACK is full, dear.
	text_jump UnknownText_0x1c4cea
	db "@"

Text_HerbShop_InsufficientFunds:
	; Hehehe… You don't have the money.
	text_jump UnknownText_0x1c4d08
	db "@"

Text_HerbShop_ComeAgain:
	; Come again, dear. Hehehehe…
	text_jump UnknownText_0x1c4d2a
	db "@"

Text_BargainShop_Intro:
	; Hiya! Care to see some bargains? I sell rare items that nobody else carries--but only one of each item.
	text_jump UnknownText_0x1c4d47
	db "@"

Text_BargainShop_CostsThisMuch:
	; costs ¥@ . Want it?
	text_jump UnknownText_0x1c4db0
	db "@"

Text_BargainShop_HereYouGo:
Text_SilphMart_HereYouGo:
Text_AdventurerMart_HereYouGo:
Text_BazaarMart_HereYouGo:
	; Thanks.
	text_jump UnknownText_0x1c4dcd
	db "@"

Text_BargainShop_BagFull:
Text_AdventurerMart_BagFull:
	; Uh-oh, your PACK is chock-full.
	text_jump UnknownText_0x1c4dd6
	db "@"

Text_BargainShop_SoldOut:
	; You bought that already. I'm all sold out of it.
	text_jump UnknownText_0x1c4df7
	db "@"

Text_BargainShop_InsufficientFunds:
Text_AdventurerMart_InsufficientFunds:
	; Uh-oh, you're short on funds.
	text_jump UnknownText_0x1c4e28
	db "@"

Text_BargainShop_ComeAgain:
	; Come by again sometime.
	text_jump UnknownText_0x1c4e46
	db "@"

Text_Pharmacist_Intro:
	; What's up? Need some medicine?
	text_jump UnknownText_0x1c4e5f
	db "@"

Text_HerbShop_HowMany:
Text_Pharmacy_HowMany:
Text_SilphMart_HowMany:
Text_AdventurerMart_HowMany:
Text_InformalMart_HowMany:
Text_BazaarMart_HowMany:
	; How many?
	text_jump UnknownText_0x1c4e7e
	db "@"

Text_Pharmacy_CostsThisMuch:
Text_SilphMart_CostsThisMuch:
Text_InformalMart_CostsThisMuch:
Text_BazaarMart_CostsThisMuch:
	; @ (S) will cost ¥@ .
	text_jump UnknownText_0x1c4e89
	db "@"

Text_Pharmacy_HereYouGo:
Text_InformalMart_HereYouGo:
	; Thanks much!
	text_jump UnknownText_0x1c4eab
	db "@"

Text_Pharmacy_BagFull:
Text_SilphMart_BagFull:
Text_InformalMart_BagFull:
Text_BazaarMart_BagFull:
	; You don't have any more space.
	text_jump UnknownText_0x1c4eb9
	db "@"

Text_Pharmacy_InsufficientFunds:
Text_SilphMart_InsufficientFunds:
Text_InformalMart_InsufficientFunds:
Text_BazaarMart_InsufficientFunds:
	; Huh? That's not enough money.
	text_jump UnknownText_0x1c4ed8
	db "@"

Text_Pharmacist_ComeAgain:
Text_InformalMart_ComeAgain:
	; All right. See you around.
	text_jump UnknownText_0x1c4ef6
	db "@"

Text_SilphMart_Intro:
	; Employees like me have access to company swag! Want to buy some?
	text_jump SilphMartIntroText
	db "@"

Text_SilphMart_ComeAgain:
	; Come again! I could use the side income.
	text_jump SilphMartComeAgainText
	db "@"

Text_AdventurerMart_Intro:
	; I picked up some rare items abroad!
	text_jump AdventurerMartIntroText
	db "@"

Text_AdventurerMart_ComeAgain:
Text_BazaarMart_ComeAgain:
	; Come by again!
	text_jump AdventurerMartComeAgainText
	db "@"

Text_InformalMart_Intro:
	; What's up? Need some supplies?
	text_jump InformalMartIntroText
	db "@"

Text_BazaarMart_Intro:
	; Come take a look at my wares!
	text_jump BazaarMartIntroText
	db "@"

Text_TMMart_CostsThisMuch:
	; @  @  will be ¥@ .
	text_jump TMMartCostsThisMuchText
	db "@"

Text_BlueCardMart_HowMayIHelpYou:
	; Which prize would you like?
	text_jump UnknownText_0x1c589f
	db "@"

Text_BlueCardMart_CostsThisMuch:
	; ? Is that right?
	text_jump UnknownText_0x1c58bc
	db "@"

Text_BlueCardMart_InsufficientFunds:
	; You don't have enough points.
	text_jump UnknownText_0x1c58e0
	db "@"

Text_BlueCardMart_BagFull:
	; You have no room for it.
	text_jump UnknownText_0x1c58ff
	db "@"

Text_BlueCardMart_HereYouGo:
	; Here you go!
	text_jump UnknownText_0x1c58d1
	db "@"

Text_BlueCardMart_ComeAgain:
	; Oh. Please come back again!
	text_jump UnknownText_0x1c591a
	db "@"

Text_BTMart_HowMayIHelpYou:
	; Welcome to the Exchange Service Corner! You can trade in your BP for prizes.
	text_jump BTMartHowMayIHelpYouText
	db "@"

Text_BTMart_CostsThisMuch:
	; @  @(s)  will cost @ BP.
	text_jump BTMartCostsThisMuchText
	db "@"

Text_BTMart_InsufficientFunds:
	; I'm sorry, but you don’t have enough BP.
	text_jump BTMartInsufficientFundsText
	db "@"

Text_BTMart_BagFull:
	; I'm sorry, but your Bag is full.
	text_jump BTMartBagFullText
	db "@"

Text_BTMart_ComeAgain:
	; Please come back any time you want!
	text_jump BTMartComeAgainText
	db "@"

SellMenu:
	call DisableSpriteUpdates
	farcall DepositSellInitPackBuffers
.loop
	farcall DepositSellPack
	ld a, [wcf66]
	and a
	jp z, .quit
	call .TryToSellItem
	jr .loop

.quit
	call SFXDelay2
	call ReturnToMapWithSpeechTextbox
	and a
	ret

.TryToSellItem:
	call CheckUniqueItemPocket
	jr z, .cant_sell
	farcall CheckItemMenu
	ld a, [wItemAttributeParamBuffer]
	ld hl, .dw
	call JumpTable
	ret

.dw
	dw .okay_to_sell
	dw .cant_buy
	dw .cant_buy
	dw .cant_buy
	dw .okay_to_sell
	dw .okay_to_sell
	dw .okay_to_sell

.cant_sell
	ld hl, TextMart_CantBuyFromYou
	call PrintText
	and a
.cant_buy
	ret

.okay_to_sell
	ld hl, Text_Mart_SellHowMany
	call PrintText
	farcall PlaceMoneyAtTopLeftOfTextbox
	farcall SelectQuantityToSell
	call ExitMenu
	jr c, .declined
	hlcoord 1, 14
	lb bc, 3, 18
	call ClearBox
	ld hl, Text_Mart_ICanPayThisMuch
	call PrintTextBoxText
	call YesNoBox
	jr c, .declined
	ld de, wMoney
	ld bc, hMoneyTemp
	call GiveMoney
	ld a, [wMartItemID]
	ld hl, wNumItems
	call TossItem
	predef PartyMonItemName
	hlcoord 1, 14
	lb bc, 3, 18
	call ClearBox
	ld hl, Text_Mart_SoldForAmount
	call PrintTextBoxText
	call PlayTransactionSound
	farcall PlaceMoneyBottomLeft
	call JoyWaitAorB

.declined
	call ExitMenu
	and a
	ret

Text_Mart_SellHowMany:
	; How many?
	text_jump UnknownText_0x1c4f33
	db "@"

Text_Mart_ICanPayThisMuch:
	; I can pay you ¥@ . Is that OK?
	text_jump UnknownText_0x1c4f3e
	db "@"

Text_Mart_HowMayIHelpYou:
	; Welcome! How may I help you?
	text_jump UnknownText_0x1c4f62
	db "@"

MenuDataHeader_BuySell:
	db $40 ; flags
	db 00, 00 ; start coords
	db 08, 07 ; end coords
	dw .menudata2
	db 1 ; default option

.menudata2
	db $80 ; strings
	db 3 ; items
	db "Buy@"
	db "Sell@"
	db "Quit@"

Text_Mart_HereYouGo:
Text_BTMart_HereYouGo:
	; Here you are. Thank you!
	text_jump UnknownText_0x1c4f80
	db "@"

Text_Mart_InsufficientFunds:
	; You don't have enough money.
	text_jump UnknownText_0x1c4f9a
	db "@"

Text_Mart_BagFull:
	; You can't carry any more items.
	text_jump UnknownText_0x1c4fb7
	db "@"

TextMart_CantBuyFromYou:
	; Sorry, I can't buy that from you.
	text_jump UnknownText_0x1c4fd7
	db "@"

Text_Mart_ComeAgain:
	; Please come again!
	text_jump UnknownText_0x1c4ff9
	db "@"

Text_Mart_AnythingElse:
	text_jump UnknownText_0x1c500d
	db "@"

Text_Mart_SoldForAmount:
	text_jump UnknownText_0x1c502e
	db "@"

PlayTransactionSound:
	call WaitSFX
	ld de, SFX_TRANSACTION
	jp PlaySFX

MartTextBox:
	call MenuTextBox
	call JoyWaitAorB
	jp ExitMenu
