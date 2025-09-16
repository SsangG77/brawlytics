//
//  BrawlersDataSource.swift
//  Brawlytics
//
//  Created by 차상진 on 5/23/25.
//

import Foundation
enum Rarity {
    case basic
    case rare
    case superRare
    case epic
    case mythic
    case legendary
    case ultraLegendary
}

enum Role: CaseIterable {
    case tanker
    case assassin
    case supporter
    case controller
    case damageDealer
    case marksmen
    case thrower
}

class BrawlersDataSource: ObservableObject {
    @Published var allBrawlers = [
        BrawlerStandard(
            name: "BULL",
            first_gadget: "T-BONE INJECTOR",
            second_gadget: "STOMPER",
            first_starPower: "BERSERKER",
            second_starPower: "TOUGH GUY",
            hypercharge: "JAWS OF STEEL",
            rarity: .rare,
            role: .tanker,
            epicGear: .superCharge,
            mythicGear: .none
        ),
        BrawlerStandard(
            name: "EL PRIMO",
            first_gadget: "SUPLEX SUPPLEMENT",
            second_gadget: "ASTEROID BELT",
            first_starPower: "EL FUEGO",
            second_starPower: "METEOR RUSH",
            hypercharge: "GRAVITY LEAP",
            rarity: .rare, 
            role: .tanker,
            epicGear: .superCharge,
            mythicGear: .none
        ),
        BrawlerStandard(
            name: "ROSA",
            first_gadget: "GROW LIGHT",
            second_gadget: "UNFRIENDLY BUSHES",
            first_starPower: "PLANT LIFE",
            second_starPower: "THORNY GLOVES",
            hypercharge: "GRASPING ROOTS",
            rarity: .rare,
            role: .tanker,
            epicGear: .none,
            mythicGear: .none
        ),
        BrawlerStandard(name: "DARRYL", first_gadget: "RECOILING ROTATOR", second_gadget: "TAR BARREL", first_starPower: "STEEL HOOPS", second_starPower: "ROLLING RELOAD", hypercharge: "BARREL O' BULLETS", rarity: .superRare, role: .tanker, epicGear: .none, mythicGear: .none),
        BrawlerStandard(name: "JACKY", first_gadget: "PNEUMATIC BOOSTER", second_gadget: "REBUILD", first_starPower: "COUNTER CRUSH", second_starPower: "HARDY HARD HAT", hypercharge: "SEISMIC EVENT", rarity: .superRare, role: .tanker, epicGear: .superCharge, mythicGear: .none),
        BrawlerStandard(name: "FRANK", first_gadget: "ACTIVE NOISE CANCELING", second_gadget: "IRRESISTIBLE ATTRACTION", first_starPower: "POWER GRAB", second_starPower: "SPONGE", hypercharge: "SEISMIC SMASH", rarity: .epic, role: .tanker, epicGear: .none, mythicGear: .none),
        BrawlerStandard(name: "BIBI", first_gadget: "VITAMIN BOOSTER", second_gadget: "EXTRA STICKY", first_starPower: "HOME RUN", second_starPower: "BATTING STANCE", hypercharge: "OUT OF BOUNDS", rarity: .epic, role: .tanker, epicGear: .none, mythicGear: .none),
        BrawlerStandard(name: "ASH", first_gadget: "CHILL PILL", second_gadget: "ROTTEN BANANA", first_starPower: "FIRST BASH", second_starPower: "MAD AS HECK", hypercharge: "Rat King", rarity: .epic, role: .tanker, epicGear: .superCharge, mythicGear: .none),
        BrawlerStandard(name: "HANK", first_gadget: "WATER BALLOONS", second_gadget: "BARRICADE", first_starPower: "IT'S GONNA BLOW", second_starPower: "TAKE COVER!", hypercharge: "HOMING FISHILE", rarity: .epic, role: .tanker, epicGear: .none, mythicGear: .none),
        BrawlerStandard(name: "BUSTER", first_gadget: "UTILITY BELT", second_gadget: "SLO-MO REPLAY", first_starPower: "BLOCKBUSTER", second_starPower: "KEVLAR VEST", hypercharge: "PLOT ARMOR", rarity: .mythic, role: .tanker, epicGear: .none, mythicGear: .none),
        BrawlerStandard(name: "OLLIE", first_gadget: "REGULATE", second_gadget: "ALLEYEZONME", first_starPower: "KICK,PUSH", second_starPower: "RENEGADE", hypercharge: "AIN'T NO HALF-SUPERING", rarity: .mythic, role: .tanker, epicGear: .none, mythicGear: .none),
        BrawlerStandard(name: "MEG", first_gadget: "JOLTING VOLTS", second_gadget: "TOOLBOX", first_starPower: "FORCE FIELD", second_starPower: "HEAVY METAL", hypercharge: "TUNGSTEN TOUGT NOT", rarity: .legendary, role: .tanker, epicGear: .none, mythicGear: .none),
        BrawlerStandard(name: "DRACO", first_gadget: "UPPER CUT", second_gadget: "LAST STAND", first_starPower: "EXPOSE", second_starPower: "SHREDDING", hypercharge: "FIRE AND FLAMES", rarity: .legendary, role: .tanker, epicGear: .none, mythicGear: .none),
        BrawlerStandard(name: "TRUNK", first_gadget: "FOR THE QUEEN!", second_gadget: "WORKER ANTS", first_starPower: "NEW INSECT OVERLORDS", second_starPower: "COLONY SCOUTS", hypercharge: "RETREAD", rarity: .epic, role: .tanker, epicGear: .none, mythicGear: .none),
        
        
        
        BrawlerStandard(name: "STU", first_gadget: "SPEED ZONE", second_gadget: "BREAKTHROUGH", first_starPower: "ZERO DRAG", second_starPower: "GASO-HEAL", hypercharge: "INFINITRO", rarity: .epic, role: .assassin, epicGear: .none, mythicGear: .none),
        BrawlerStandard(name: "EDGAR", first_gadget: "LET'S FLY", second_gadget: "HARDCORE", first_starPower: "HARD LANDING", second_starPower: "FISTICUFFS", hypercharge: "OUTBURST", rarity: .epic, role: .assassin, epicGear: .superCharge, mythicGear: .none),
        BrawlerStandard(name: "SAM", first_gadget: "MAGNETIC FIELD", second_gadget: "PULSE REPELLENT", first_starPower: "HEARTY RECOVERY", second_starPower: "REMOTE RECHARGE", hypercharge: "HYPER FIST", rarity: .epic, role: .assassin, epicGear: .none, mythicGear: .none),
        BrawlerStandard(name: "SHADE", first_gadget: "LONGARMS", second_gadget: "JUMP SCARE", first_starPower: "SPOOKY SPEEDSTER", second_starPower: "HARDENED HOODIE", hypercharge: "THE FRIGHTENER", rarity: .epic, role: .assassin, epicGear: .none, mythicGear: .none),
        BrawlerStandard(name: "MORTIS", first_gadget: "COMBO SPINNER", second_gadget: "SURVIVAL SHOVEL", first_starPower: "CREEPY HARVEST", second_starPower: "COILED SNAKE", hypercharge: "BLOOD BOOMERANG", rarity: .mythic, role: .assassin, epicGear: .none, mythicGear: .batStorm),
        BrawlerStandard(name: "BUZZ", first_gadget: "RESERVE BUOY", second_gadget: "X-RAY-SHADES", first_starPower: "TOUGHER TORPEDO", second_starPower: "EYES SHARP", hypercharge: "BUZZWATCH", rarity: .mythic, role: .assassin, epicGear: .none, mythicGear: .none),
        BrawlerStandard(name: "FANG", first_gadget: "CORN-FU", second_gadget: "ROUNDHOUSE KICK", first_starPower: "FRESH KICKS", second_starPower: "DIVINE SOLES", hypercharge: "DRAGON KICK", rarity: .mythic, role: .assassin, epicGear: .none, mythicGear: .none),
        BrawlerStandard(name: "MICO", first_gadget: "CLIPPING SCREAM", second_gadget: "PRESTO", first_starPower: "MONKEY BUSINESS", second_starPower: "RECORD SMASH", hypercharge: "SOUND CHECK", rarity: .mythic, role: .assassin, epicGear: .none, mythicGear: .none),
        BrawlerStandard(name: "MELODIE", first_gadget: "PERFECT PITCH", second_gadget: "INTERLUDE", first_starPower: "FAST BEATS", second_starPower: "EXTENDED MIX", hypercharge: "FLASH MOB", rarity: .mythic, role: .assassin, epicGear: .none, mythicGear: .none),
        BrawlerStandard(name: "LILY", first_gadget: "VANISH", second_gadget: "REPOT", first_starPower: "SPIKY", second_starPower: "VIGILANCE", hypercharge: "GERMINATE", rarity: .mythic, role: .assassin, epicGear: .none, mythicGear: .none),
        BrawlerStandard(name: "CROW", first_gadget: "DEFENSE BOOSTER", second_gadget: "SLOWING TOXIN", first_starPower: "EXTRA TOXIC", second_starPower: "CARRION CROW", hypercharge: "UTILITY KNIVES", rarity: .legendary, role: .assassin, epicGear: .none, mythicGear: .enduringToxin),
        BrawlerStandard(name: "LEON", first_gadget: "CLONE PROJECTOR", second_gadget: "LOLLIPOP DROP", first_starPower: "SMOKE TRAILS", second_starPower: "INVISIHEAL", hypercharge: "LIMBO", rarity: .legendary, role: .assassin, epicGear: .none, mythicGear: .lingeringSmoke),
        BrawlerStandard(name: "CORDELIUS", first_gadget: "REPLANTING", second_gadget: "POISON MUSHROOM", first_starPower: "COMBOSHROOMS", second_starPower: "MUSHROOM KINGDOM", hypercharge: "COMPLETE DARKNESS", rarity: .legendary, role: .assassin, epicGear: .none, mythicGear: .none),
        BrawlerStandard(name: "KENJI", first_gadget: "DASHI DASH", second_gadget: "HOSOMAKI HEALING", first_starPower: "STUDIED THE BLADE", second_starPower: "NIGIRI NEMESIS", hypercharge: "ALL YOU CAN EAT", rarity: .legendary, role: .assassin, epicGear: .none, mythicGear: .none),
        BrawlerStandard(name: "KAZE", first_gadget: "GRACIOUS HOST", second_gadget: "HENSOJUTSU", first_starPower: "ADVANCED TECHNIQUES", second_starPower: "GRATUITY INCLUDED", hypercharge: "ANCIENT ENERGY", rarity: .ultraLegendary, role: .assassin, epicGear: .none, mythicGear: .none),
        BrawlerStandard(name: "ALLI", first_gadget: "FEED THE GATORS", second_gadget: "COLD-BLOODED", first_starPower: "LIZARD LIMBS", second_starPower: "YOU BETTER RUN, YOU BETTER TAKE COVER", hypercharge: "", rarity: .mythic, role: .assassin, epicGear: .none, mythicGear: .none),
        
        BrawlerStandard(name: "POCO", first_gadget: "TUNING FORK", second_gadget: "PROTECTIVE TUNES", first_starPower: "DA CAPO!", second_starPower: "SCREECHING SOLO", hypercharge: "MEDIC'S MELODY", rarity: .rare, role: .supporter, epicGear: .none, mythicGear: .none),
        BrawlerStandard(name: "GUS", first_gadget: "KOOKY POPPER", second_gadget: "SOUL SWITCHER", first_starPower: "HEALTH BONANZA", second_starPower: "SPIRIT ANIMAL", hypercharge: "SPOOKY POP", rarity: .superRare, role: .supporter, epicGear: .none, mythicGear: .none),
        BrawlerStandard(name: "PAM", first_gadget: "PULSE MODULATOR", second_gadget: "SCRAPSUCKER", first_starPower: "MAMA'S HUG", second_starPower: "MAMA'S SQUEEZE", hypercharge: "", rarity: .epic, role: .supporter, epicGear: .none, mythicGear: .superTurret),
        BrawlerStandard(name: "BERRY", first_gadget: "FRIENDSHIP IS GREAT", second_gadget: "HEALTHY ADDITIVES", first_starPower: "FLOOR IS FINE", second_starPower: "MAKING A MESS", hypercharge: "Double Scoops", rarity: .epic, role: .supporter, epicGear: .none, mythicGear: .none),
        BrawlerStandard(name: "MAX", first_gadget: "PHASE SHIFTER", second_gadget: "SNEAKY SNEAKERS", first_starPower: "SUPER CHARGED", second_starPower: "RUN N GUN", hypercharge: "UNLIMITED ENERGY", rarity: .mythic, role: .supporter, epicGear: .none, mythicGear: .none),
        BrawlerStandard(name: "BYRON", first_gadget: "SHOT IN THE ARM", second_gadget: "BOOSTER SHOTS", first_starPower: "MALAISE", second_starPower: "INJECTION", hypercharge: "UNSTABLE CONCOCTION", rarity: .mythic, role: .supporter, epicGear: .none, mythicGear: .none),
        BrawlerStandard(name: "RUFFS", first_gadget: "TAKE COVER", second_gadget: "AIR SUPPORT", first_starPower: "AIR SUPERIORITY", second_starPower: "FIELD PROMOTION", hypercharge: "THE GOODEST BOY", rarity: .mythic, role: .supporter, epicGear: .none, mythicGear: .none),
        BrawlerStandard(name: "GRAY", first_gadget: "WALKING CANE", second_gadget: "GRAND PIANO", first_starPower: "FAKE INJURY", second_starPower: "NEW PERSPECTIVE", hypercharge: "Another Dimention", rarity: .mythic, role: .supporter, epicGear: .none, mythicGear: .none),
        BrawlerStandard(name: "DOUG", first_gadget: "DOUBLE SAUSAGE", second_gadget: "EXTRA MUSTARD", first_starPower: "FAST FOOD", second_starPower: "SELF SERVICE", hypercharge: "FREE TOPPINGS", rarity: .mythic, role: .supporter, epicGear: .none, mythicGear: .none),
        BrawlerStandard(name: "KIT", first_gadget: "CARDBOARD BOX", second_gadget: "CHEESEBURGER", first_starPower: "POWER HUNGRY", second_starPower: "OVERLY ATTACHED", hypercharge: "MAKING BISCUITS", rarity: .legendary, role: .supporter, epicGear: .none, mythicGear: .none),
        BrawlerStandard(name: "JAE-YONG", first_gadget: "WEEKEND WARRIOR", second_gadget: "TIME FOR A SLOW SONG", first_starPower: "THE CROWD GOES MILD", second_starPower: "EXTRA HIGH NOTE", hypercharge: "CROWD-PLEASEP", rarity: .mythic, role: .supporter, epicGear: .none, mythicGear: .none),
        
        BrawlerStandard(name: "JESSIE", first_gadget: "SPARK PLUG", second_gadget: "RECOIL SPRING", first_starPower: "ENERGIZE", second_starPower: "SHOCKY", hypercharge: "SCRAPPY 2.0", rarity: .superRare, role: .controller, epicGear: .petPower, mythicGear: .none),
        BrawlerStandard(name: "PENNY", first_gadget: "SALTY BARREL", second_gadget: "TRUSTY SPYGLASS", first_starPower: "HEAVY COFFERS", second_starPower: "MASTER BLASTER", hypercharge: "NEW LOBBER", rarity: .superRare, role: .controller, epicGear: .petPower, mythicGear: .none),
        BrawlerStandard(name: "BO", first_gadget: "SUPER TOTEM", second_gadget: "TRIPWIRE", first_starPower: "CIRCLING EAGLE", second_starPower: "SNARE A BEAR", hypercharge: "CATCH A BEAR", rarity: .epic, role: .controller, epicGear: .reloadSpeed, mythicGear: .none),
        BrawlerStandard(name: "EMZ", first_gadget: "FRIENDZONER", second_gadget: "ACID SPRAY", first_starPower: "BAD KARMA", second_starPower: "HYPE", hypercharge: "OVERERHYPED HAZE", rarity: .epic, role: .controller, epicGear: .none, mythicGear: .none),
        BrawlerStandard(name: "GRIFF", first_gadget: "PIGGY BANK", second_gadget: "COIN SHOWER", first_starPower: "KEEP THE CHANGE", second_starPower: "BUSINESS RESILIENCE", hypercharge: "TAX REBATE", rarity: .epic, role: .controller, epicGear: .reloadSpeed, mythicGear: .none),
        BrawlerStandard(name: "GALE", first_gadget: "SPRING EJECTOR", second_gadget: "TWISTER", first_starPower: "BLUSTERY BLOW", second_starPower: "FREEZING SNOW", hypercharge: "BLIZZARD", rarity: .epic, role: .controller, epicGear: .none, mythicGear: .none),
        BrawlerStandard(name: "MEEPLE", first_gadget: "MANSIONS OF MEEPLE", second_gadget: "RAGEQUIT", first_starPower: "DO NOT PASS GO", second_starPower: "RULE BENDING", hypercharge: "THE LAST RULEBENDER", rarity: .epic, role: .controller, epicGear: .none, mythicGear: .none),
        BrawlerStandard(name: "GENE", first_gadget: "LAMP BLOWOUT", second_gadget: "VENGEFUL SPIRITS", first_starPower: "MAGIC PUFFS", second_starPower: "SPIRIT SLAP", hypercharge: "HYPER HAND", rarity: .mythic, role: .controller, epicGear: .none, mythicGear: .talkToTheHand),
        BrawlerStandard(name: "MR. P", first_gadget: "SERVICE BELL", second_gadget: "PORTER REINFORCEMENTS", first_starPower: "HANDLE WITH CARE", second_starPower: "REVOLVING DOOR", hypercharge: "SUPER PORTERS! ASSEMBLE!", rarity: .mythic, role: .controller, epicGear: .petPower, mythicGear: .none),
        BrawlerStandard(name: "SQUEAK", first_gadget: "WINDUP", second_gadget: "RESIDUE", first_starPower: "CHAIN REACTION", second_starPower: "SUPER STICKY", hypercharge: "BOUNCY BLOB", rarity: .mythic, role: .controller, epicGear: .none, mythicGear: .none),
        BrawlerStandard(name: "LOU", first_gadget: "ICE BLOCK", second_gadget: "CRYO SYRUP", first_starPower: "SUPERCOOL", second_starPower: "HYPOTHERMIA", hypercharge: "SLUSHIE STORM", rarity: .mythic, role: .controller, epicGear: .superCharge, mythicGear: .none),
        BrawlerStandard(name: "OTIS", first_gadget: "DORMANT STAR", second_gadget: "PHAT SPLATTER", first_starPower: "STENCIL GLUE", second_starPower: "INK REFILLS", hypercharge: "SILENT STUNNER", rarity: .mythic, role: .controller, epicGear: .superCharge, mythicGear: .none),
        BrawlerStandard(name: "WILLOW", first_gadget: "SPELLBOUND", second_gadget: "DIVE", first_starPower: "LOVE IS BLIND", second_starPower: "OBSESSION", hypercharge: "PSYCHOC SAFETY", rarity: .mythic, role: .controller, epicGear: .none, mythicGear: .none),
        BrawlerStandard(name: "CHUCK", first_gadget: "REROUTING", second_gadget: "GHOST TRAIN", first_starPower: "PIT STOP", second_starPower: "TICKETS PLEASE!", hypercharge: "FULL STEAM AHEAD", rarity: .mythic, role: .controller, epicGear: .none, mythicGear: .none),
        BrawlerStandard(name: "CHARLIE", first_gadget: "SPIDERS", second_gadget: "PERSONAL SPACE", first_starPower: "DIGESTIVE", second_starPower: "SLIMY", hypercharge: "PESTILENCE", rarity: .mythic, role: .controller, epicGear: .none, mythicGear: .none),
        BrawlerStandard(name: "SANDY", first_gadget: "SLEEP STIMULATOR", second_gadget: "SWEET DREAMS", first_starPower: "RUDE SANDS", second_starPower: "HEALING WINDS", hypercharge: "SWIFT WINDS", rarity: .legendary, role: .controller, epicGear: .none, mythicGear: .exhaustingStorm),
        BrawlerStandard(name: "AMBER", first_gadget: "FIRE STARTERS", second_gadget: "DANCING FLAMES", first_starPower: "WILD FLAMES", second_starPower: "SCORCHIN' SIPHON", hypercharge: "OIL SPILL", rarity: .legendary, role: .controller, epicGear: .reloadSpeed, mythicGear: .stickyOil),
        BrawlerStandard(name: "FINX", first_gadget: "BACK TO THE FINXTURE", second_gadget: "NO ESCAPE", first_starPower: "HIEROGLYPH HALT", second_starPower: "PRIMER", hypercharge: "TEMPORAL TRAVELING", rarity: .mythic, role: .controller, epicGear: .none, mythicGear: .none),
        
        BrawlerStandard(name: "SHELLY", first_gadget: "FAST FORWARD", second_gadget: "CLAY PIGEONS", first_starPower: "SHELL SHOCK", second_starPower: "BAND-AID", hypercharge: "DOUBLE BARREL", rarity: .basic, role: .damageDealer, epicGear: .none, mythicGear: .none),
        BrawlerStandard(name: "NITA", first_gadget: "BEAR PAWS", second_gadget: "FAUX FUR", first_starPower: "BEAR WITH ME", second_starPower: "HYPER BEAR", hypercharge: "HYPERBEARING", rarity: .rare, role: .damageDealer, epicGear: .petPower, mythicGear: .none),
        BrawlerStandard(name: "COLT", first_gadget: "SPEEDLOADER", second_gadget: "SILVER BULLET", first_starPower: "SLICK BOOTS", second_starPower: "MAGNUM SPECIAL", hypercharge: "DUAL WIELDING", rarity: .rare, role: .damageDealer, epicGear: .reloadSpeed, mythicGear: .none),
        BrawlerStandard(name: "8-BIT", first_gadget: "CHEAT CARTRIDGE", second_gadget: "EXTRA CREDITS", first_starPower: "BOOSTED BOOSTER", second_starPower: "PLUGGED IN", hypercharge: "AIMBOT", rarity: .superRare, role: .damageDealer, epicGear: .reloadSpeed, mythicGear: .none),
        BrawlerStandard(name: "RICO", first_gadget: "MULTIBALL LAUNCHER", second_gadget: "BOUNCY CASTLE", first_starPower: "SUPER BOUNCY", second_starPower: "ROBO RETREAT", hypercharge: "TRICK SHOT KING", rarity: .superRare, role: .damageDealer, epicGear: .reloadSpeed, mythicGear: .none),
        BrawlerStandard(name: "CARL", first_gadget: "HEAT EJECTOR", second_gadget: "FLYING HOOK", first_starPower: "POWER THROW", second_starPower: "PROTECTIVE PIROUETTE", hypercharge: "FLAME SPIN", rarity: .superRare, role: .damageDealer, epicGear: .none, mythicGear: .none),
        BrawlerStandard(name: "COLETTE", first_gadget: "NA-AH!", second_gadget: "GOTCHA!", first_starPower: "PUSH IT", second_starPower: "MASS TAX", hypercharge: "TEEN SPIRIT", rarity: .epic, role: .damageDealer, epicGear: .none, mythicGear: .none),
        BrawlerStandard(name: "LOLA", first_gadget: "FREEZE FRAME", second_gadget: "STUNT DOUBLE", first_starPower: "IMPROVISE", second_starPower: "SEALED WITH A KISS", hypercharge: "INFLATED EGO", rarity: .epic, role: .damageDealer, epicGear: .reloadSpeed, mythicGear: .none),
        BrawlerStandard(name: "PEARL", first_gadget: "OVERCOOKED", second_gadget: "MADE WITH LOVE", first_starPower: "HEAT RETENTION", second_starPower: "HEAT SHIELD", hypercharge: "PYROLITIC", rarity: .epic, role: .damageDealer, epicGear: .none, mythicGear: .none),
        BrawlerStandard(name: "TARA", first_gadget: "PSYCHIC ENHANCER", second_gadget: "SUPPORT FROM BEYOND", first_starPower: "BLACK PORTAL", second_starPower: "HEALING SHADE", hypercharge: "SUPERMASSIVE", rarity: .mythic, role: .damageDealer, epicGear: .petPower, mythicGear: .none),
        BrawlerStandard(name: "EVE", first_gadget: "GOTTA GO!", second_gadget: "MOTHERLY LOVE", first_starPower: "UNNATURAL ORDER", second_starPower: "HAPPY SURPRISE", hypercharge: "Generations", rarity: .mythic, role: .damageDealer, epicGear: .reloadSpeed, mythicGear: .quadruplets),
        BrawlerStandard(name: "R-T", first_gadget: "OUT OF LINE", second_gadget: "HACKS!", first_starPower: "QUICK MATHS", second_starPower: "RECORDING", hypercharge: "360-DEGREE SURVEILLANCE", rarity: .mythic, role: .damageDealer, epicGear: .none, mythicGear: .none),
        BrawlerStandard(name: "CLANCY", first_gadget: "SNAPPY SHOOTING", second_gadget: "TACTICAL RETREAT", first_starPower: "RECON", second_starPower: "PUMPING UP", hypercharge: "RECALL OF DUTY", rarity: .mythic, role: .damageDealer, epicGear: .none, mythicGear: .none),
        BrawlerStandard(name: "MOE", first_gadget: "DODGY DIGGING", second_gadget: "RAT RACE", first_starPower: "SKIPPING STONES", second_starPower: "SPEEDING TICKET", hypercharge: "THE BIG CHEESE", rarity: .mythic, role: .damageDealer, epicGear: .none, mythicGear: .none),
        BrawlerStandard(name: "SPIKE", first_gadget: "POPPING PINCUSHION", second_gadget: "LIFE PLANT", first_starPower: "FERTILIZE", second_starPower: "CURVEBALL", hypercharge: "BLOOMING SEASON", rarity: .legendary, role: .damageDealer, epicGear: .none, mythicGear: .stickySpikes),
        BrawlerStandard(name: "SURGE", first_gadget: "POWER SURGE", second_gadget: "POWER SHIELD", first_starPower: "TO THE MAX!", second_starPower: "SERVE ICE COLD", hypercharge: "LEVEL 5", rarity: .legendary, role: .damageDealer, epicGear: .none, mythicGear: .none),
        BrawlerStandard(name: "CHESTER", first_gadget: "SPICY DICE", second_gadget: "CANDY BEANS", first_starPower: "SINGLE BELL'O'MANIA", second_starPower: "SNEAK PEEK", hypercharge: "CRUNCHY, CHEWY, GOOEY", rarity: .legendary, role: .damageDealer, epicGear: .none, mythicGear: .none),
        BrawlerStandard(name: "LUMI", first_gadget: "INFERNAL FLAMES", second_gadget: "GRIM AND FROSTBITTEN", first_starPower: "42% BURNT", second_starPower: "HALF TIME", hypercharge: "DRUM SOLO", rarity: .mythic, role: .damageDealer, epicGear: .none, mythicGear: .none),
        
        BrawlerStandard(name: "BROCK", first_gadget: "ROCKET LACES", second_gadget: "ROCKET FUEL", first_starPower: "MORE ROCKETS!", second_starPower: "ROCKET NO. 4", hypercharge: "ROCKET BARRAGE", rarity: .rare, role: .marksmen, epicGear: .reloadSpeed, mythicGear: .none),
        BrawlerStandard(name: "NANI", first_gadget: "WARPIN' TIME", second_gadget: "RETURN TO SENDER", first_starPower: "AUTOFOCUS", second_starPower: "TEMPERED STEEL", hypercharge: "BIG PEEP", rarity: .epic, role: .marksmen, epicGear: .superCharge, mythicGear: .none),
        BrawlerStandard(name: "MANDY", first_gadget: "CARAMELIZE", second_gadget: "COOKIE CRUMBS", first_starPower: "IN MY SIGHTS", second_starPower: "HARD CANDY", hypercharge: "SUGAR FOR ALL!", rarity: .epic, role: .marksmen, epicGear: .none, mythicGear: .none),
        BrawlerStandard(name: "MAISIE", first_gadget: "DISENGAGE!", second_gadget: "FINISH THEM!", first_starPower: "PINPOINT PRECISION", second_starPower: "TREMORS", hypercharge: "AFTERMATH", rarity: .epic, role: .marksmen, epicGear: .none, mythicGear: .none),
        BrawlerStandard(name: "BELLE", first_gadget: "NEST EGG", second_gadget: "REVERSE POLARITY", first_starPower: "POSITIVE FEEDBACK", second_starPower: "GROUNDED", hypercharge: "MAGNETIC", rarity: .epic, role: .marksmen, epicGear: .reloadSpeed, mythicGear: .none),
        BrawlerStandard(name: "BONNIE", first_gadget: "SUGAR RUSH", second_gadget: "CRASH TEST", first_starPower: "BLACK POWDER", second_starPower: "WISDOM TOOTH", hypercharge: "DAREDEVIL", rarity: .epic, role: .marksmen, epicGear: .superCharge, mythicGear: .none),
        BrawlerStandard(name: "BEA", first_gadget: "HONEY MOLASSES", second_gadget: "RATTLED HIVE", first_starPower: "INSTA BEALOAD", second_starPower: "HONEYCOMB", hypercharge: "PROTECT THE QUEEN", rarity: .epic, role: .marksmen, epicGear: .none, mythicGear: .none),
        BrawlerStandard(name: "ANGELO", first_gadget: "STINGING FLIGHT", second_gadget: "MASTER FLETCHER", first_starPower: "EMPOWER", second_starPower: "FLOW", hypercharge: "IN MY ELEMENT", rarity: .epic, role: .marksmen, epicGear: .none, mythicGear: .none),
        BrawlerStandard(name: "JANET", first_gadget: "DROP THE BASS", second_gadget: "BACKSTAGE PASS", first_starPower: "STAGE VIEW", second_starPower: "VOCAL WARM UP", hypercharge: "Magnus Opus", rarity: .mythic, role: .marksmen, epicGear: .none, mythicGear: .none),
        BrawlerStandard(name: "PIPER", first_gadget: "AUTO AIMER", second_gadget: "HOMEMADE RECIPE", first_starPower: "AMBUSH", second_starPower: "SNAPPY SNIPING", hypercharge: "BOPPIN'", rarity: .epic, role: .marksmen, epicGear: .none, mythicGear: .none),
        
        BrawlerStandard(name: "BARLEY", first_gadget: "STICKY SYRUP MIXER", second_gadget: "HERBAL TONIC", first_starPower: "MEDICAL USE", second_starPower: "EXTRA NOXIOUS", hypercharge: "BOTTLE-UP RAGE", rarity: .epic, role: .thrower, epicGear: .none, mythicGear: .none),
        BrawlerStandard(name: "DYNAMIKE", first_gadget: "FIDGET SPINNER", second_gadget: "SATCHEL CHARGE", first_starPower: "DYNA-JUMP", second_starPower: "DEMOLITION", hypercharge: "BOOMER", rarity: .superRare, role: .thrower, epicGear: .none, mythicGear: .none),
        BrawlerStandard(name: "TICK", first_gadget: "MINE MANIA", second_gadget: "LAST HURRAH", first_starPower: "WELL OILED", second_starPower: "AUTOMA-TICK RELOAD", hypercharge: "HEAD STRONG", rarity: .superRare, role: .thrower, epicGear: .none, mythicGear: .thiccHead),
        BrawlerStandard(name: "GROM", first_gadget: "WATCHTOWER", second_gadget: "RADIO CHECK", first_starPower: "FOOT PATROL", second_starPower: "X-FACTOR", hypercharge: "GROM BOOM GOSS BOOM", rarity: .epic, role: .thrower, epicGear: .none, mythicGear: .none),
        BrawlerStandard(name: "LARRY & LAWRIE", first_gadget: "ORDER: SWAP", second_gadget: "ORDER: FALL BACK", first_starPower: "PROTOCOL: PROTECT", second_starPower: "PROTOCOL: ASSIST", hypercharge: "", rarity: .epic, role: .thrower, epicGear: .none, mythicGear: .none),
        BrawlerStandard(name: "SPROUT", first_gadget: "GARDEN MULCHER", second_gadget: "TRANSPLANT", first_starPower: "OVERGROWTH", second_starPower: "PHOTOSYNTHESIS", hypercharge: "THORNS", rarity: .mythic, role: .thrower, epicGear: .superCharge, mythicGear: .none),
        BrawlerStandard(name: "JUJU", first_gadget: "VOODOO CHILE", second_gadget: "ELEMENTALIST", first_starPower: "GUARDED GRIS-GRIS", second_starPower: "NUMBING NEEDLES", hypercharge: "BOKOR", rarity: .mythic, role: .thrower, epicGear: .none, mythicGear: .none)
    ]
    
    
    
}
