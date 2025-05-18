//
//  BrawlerViewModel.swift
//  Brawlytics
//
//  Created by 차상진 on 11/6/24.
//

import Foundation
import SwiftUI
import Combine

// 데이터 로딩을 관리하는 ViewModel
class BrawlersViewModel: ObservableObject {
    @Published var isLoading = true          // 로딩 상태

    
    //MARK: - 기어 브롤러 배열
    //영웅기어를 가지고있는 브롤러 배열
    @Published var reload_speed_gear_brawlers = ["BELLE", "EVE","LOLA","BO","BROCK","COLT","8-BIT","AMBER","RICO","GRIFF"]
    @Published var super_charge_gear_brawlers = ["ASH","LOU","OTIS","BULL","NANI","BONNIE","EDGAR","SPROUT","EL PRIMO","JACKY"]
    @Published var pet_power_gear_brawlers = ["NITA","JESSIE","PENNY","TARA","MR. P"]
    
    //신화기어를 가지고 있는 브롤러 배열
    @Published var mythic_gear_brawlers = ["TICK","GENE","CROW","SANDY","SPIKE","LEON","AMBER","EVE","PAM","MORTIS"]
    
    
    //MARK: - 기어 배열
    //초희귀 기어 이름 배열
    @Published var gear_names = ["SPEED", "HEALTH", "DAMAGE", "VISION", "SHIELD", "GADGET COOLDOWN"]
    
    
    //신화 기어 이름 배열
    @Published var mythic_gear_name = [
        "THICC HEAD", //틱
        "TALK TO THE HAND", //진
        "ENDURING TOXIN", //크로우
        "EXHAUSTING STORM", //샌디
        "STICKY SPIKES", //스파이크
        "LINGERING SMOKE", //레온
        "STICKY OIL", //앰버
        "QUADRUPLETS", //이브
        "SUPER TURRET", //팸
        "BAT STORM" //모티스
    ]
    
    
    //희귀 브롤러
    @Published var rare = ["NITA", "COLT", "BULL", "BROCK", "EL PRIMO", "BARLEY", "POCO", "ROSA"]
    
    //초희귀 브롤러
    @Published var super_rare = ["8-BIT", "CARL", "DARRYL", "DYNAMIKE", "GUS", "JACKY", "JESSIE", "PENNY", "RICO", "TICK"]
    
    //영웅 브롤러
    @Published var epic = ["ANGELO","ASH","BEA","BELLE","BERRY","BIBI","BO","BONNIE","COLETTE","EDGAR","EMZ","FRANK","GALE","GRIFF","GROM","HANK","LARRY & LAWRIE","LOLA","MAISIE","MANDY","NANI","PAM","PEARL","PIPER","SAM","SHADE","STU", "MEEPLE"]
    
    //신화 브롤러
    @Published var mythic = ["BUSTER","BUZZ","BYRON","CHARLIE","CHUCK","CLANCY","DOUG","EVE","FANG","GENE","GRAY","JANET","JUJU","LILY","LOU","MAX","MELODIE","MICO","MOE","MORTIS","MR. P","OTIS","R-T","RUFFS","SPROUT","SQUEAK","TARA","WILLOW", "OLLIE", "FINX", "LUMI", "JAE-YONG"]
    
    //전설 브롤러
    @Published var legendary = ["AMBER","CHESTER","CORDELIUS","CROW","DRACO","KENJI","KIT","LEON","MEG","SANDY","SPIKE","SURGE"]
    
    @Published var ultra_legendary = ["KAZE"]
    
    @Published var tanker_brawlers_standard = [
        Brawler_standard(name: "BULL", first_gadget: "T-BONE INJECTOR", second_gadget: "STOMPER", first_starPower: "BERSERKER", second_starPower: "TOUGH GUY", hypercharge: "JAWS OF STEEL"),
        Brawler_standard(name: "EL PRIMO", first_gadget: "SUPLEX SUPPLEMENT", second_gadget: "ASTEROID BELT", first_starPower: "EL FUEGO", second_starPower: "METEOR RUSH", hypercharge: "GRAVITY LEAP"),
        Brawler_standard(name: "ROSA", first_gadget: "GROW LIGHT", second_gadget: "UNFRIENDLY BUSHES", first_starPower: "PLANT LIFE", second_starPower: "THORNY GLOVES", hypercharge: "GRASPING ROOTS"),
        Brawler_standard(name: "DARRYL", first_gadget: "RECOILING ROTATOR", second_gadget: "TAR BARREL", first_starPower: "STEEL HOOPS", second_starPower: "ROLLING RELOAD", hypercharge: "BARREL O' BULLETS"),
        Brawler_standard(name: "JACKY", first_gadget: "PNEUMATIC BOOSTER", second_gadget: "REBUILD", first_starPower: "COUNTER CRUSH", second_starPower: "HARDY HARD HAT", hypercharge: "SEISMIC EVENT"),
        Brawler_standard(name: "FRANK", first_gadget: "ACTIVE NOISE CANCELING", second_gadget: "IRRESISTIBLE ATTRACTION", first_starPower: "POWER GRAB", second_starPower: "SPONGE", hypercharge: "SEISMIC SMASH"),
        Brawler_standard(name: "BIBI", first_gadget: "VITAMIN BOOSTER", second_gadget: "EXTRA STICKY", first_starPower: "HOME RUN", second_starPower: "BATTING STANCE", hypercharge: "OUT OF BOUNDS"),
        Brawler_standard(name: "ASH", first_gadget: "CHILL PILL", second_gadget: "ROTTEN BANANA", first_starPower: "FIRST BASH", second_starPower: "MAD AS HECK", hypercharge: "Rat King"),
        Brawler_standard(name: "HANK", first_gadget: "WATER BALLOONS", second_gadget: "BARRICADE", first_starPower: "IT'S GONNA BLOW", second_starPower: "TAKE COVER!", hypercharge: "HOMING FISHILE"),
        Brawler_standard(name: "BUSTER", first_gadget: "UTILITY BELT", second_gadget: "SLO-MO REPLAY", first_starPower: "BLOCKBUSTER", second_starPower: "KEVLAR VEST", hypercharge: "PLOT ARMOR"),
        Brawler_standard(name: "OLLIE", first_gadget: "REGULATE", second_gadget: "ALLEYEZONME", first_starPower: "KICK,PUSH", second_starPower: "RENEGADE", hypercharge: ""),
        Brawler_standard(name: "MEG", first_gadget: "JOLTING VOLTS", second_gadget: "TOOLBOX", first_starPower: "FORCE FIELD", second_starPower: "HEAVY METAL", hypercharge: "TUNGSTEN TOUGT NOT"),
        Brawler_standard(name: "DRACO", first_gadget: "UPPER CUT", second_gadget: "LAST STAND", first_starPower: "EXPOSE", second_starPower: "SHREDDING", hypercharge: ""),
    ]
    
    @Published var assassin_brawlers_standard = [
        Brawler_standard(name: "STU", first_gadget: "SPEED ZONE", second_gadget: "BREAKTHROUGH", first_starPower: "ZERO DRAG", second_starPower: "GASO-HEAL", hypercharge: "INFINITRO"),
        Brawler_standard(name: "EDGAR", first_gadget: "LET'S FLY", second_gadget: "HARDCORE", first_starPower: "HARD LANDING", second_starPower: "FISTICUFFS", hypercharge: "OUTBURST"),
        Brawler_standard(name: "SAM", first_gadget: "MAGNETIC FIELD", second_gadget: "PULSE REPELLENT", first_starPower: "HEARTY RECOVERY", second_starPower: "REMOTE RECHARGE", hypercharge: "HYPER FIST"),
        Brawler_standard(name: "SHADE", first_gadget: "LONGARMS", second_gadget: "JUMP SCARE", first_starPower: "SPOOKY SPEEDSTER", second_starPower: "HARDENED HOODIE", hypercharge: ""),
        Brawler_standard(name: "MORTIS", first_gadget: "COMBO SPINNER", second_gadget: "SURVIVAL SHOVEL", first_starPower: "CREEPY HARVEST", second_starPower: "COILED SNAKE", hypercharge: "BLOOD BOOMERANG"),
        Brawler_standard(name: "BUZZ", first_gadget: "RESERVE BUOY", second_gadget: "X-RAY-SHADES", first_starPower: "TOUGHER TORPEDO", second_starPower: "EYES SHARP", hypercharge: "BUZZWATCH"),
        Brawler_standard(name: "FANG", first_gadget: "CORN-FU", second_gadget: "ROUNDHOUSE KICK", first_starPower: "FRESH KICKS", second_starPower: "DIVINE SOLES", hypercharge: "DRAGON KICK"),
        Brawler_standard(name: "MICO", first_gadget: "CLIPPING SCREAM", second_gadget: "PRESTO", first_starPower: "MONKEY BUSINESS", second_starPower: "RECORD SMASH", hypercharge: "SOUND CHECK"),
        Brawler_standard(name: "MELODIE", first_gadget: "PERFECT PITCH", second_gadget: "INTERLUDE", first_starPower: "FAST BEATS", second_starPower: "EXTENDED MIX", hypercharge: "FLASH MOB"),
        Brawler_standard(name: "LILY", first_gadget: "VANISH", second_gadget: "REPOT", first_starPower: "SPIKY", second_starPower: "VIGILANCE", hypercharge: "GERMINATE"),
        Brawler_standard(name: "CROW", first_gadget: "DEFENSE BOOSTER", second_gadget: "SLOWING TOXIN", first_starPower: "EXTRA TOXIC", second_starPower: "CARRION CROW", hypercharge: "UTILITY KNIVES"),
        Brawler_standard(name: "LEON", first_gadget: "CLONE PROJECTOR", second_gadget: "LOLLIPOP DROP", first_starPower: "SMOKE TRAILS", second_starPower: "INVISIHEAL", hypercharge: "LIMBO"),
        Brawler_standard(name: "CORDELIUS", first_gadget: "REPLANTING", second_gadget: "POISON MUSHROOM", first_starPower: "COMBOSHROOMS", second_starPower: "MUSHROOM KINGDOM", hypercharge: "COMPLETE DARKNESS"),
        Brawler_standard(name: "KENJI", first_gadget: "DASHI DASH", second_gadget: "HOSOMAKI HEALING", first_starPower: "STUDIED THE BLADE", second_starPower: "NIGIRI NEMESIS", hypercharge: "ALL YOU CAN EAT"),
        Brawler_standard(name: "KAZE", first_gadget: "GRACIOUS HOST", second_gadget: "HENSOJUTSU", first_starPower: "ADVANCED TECHNIQUES", second_starPower: "GRATUITY INCLUDED", hypercharge: "ANCIENT ENERGY"),
    ]
    
    @Published var supporter_brawlers_standard = [
        Brawler_standard(name: "POCO", first_gadget: "TUNING FORK", second_gadget: "PROTECTIVE TUNES", first_starPower: "DA CAPO!", second_starPower: "SCREECHING SOLO", hypercharge: "MEDIC'S MELODY"),
        Brawler_standard(name: "GUS", first_gadget: "KOOKY POPPER", second_gadget: "SOUL SWITCHER", first_starPower: "HEALTH BONANZA", second_starPower: "SPIRIT ANIMAL", hypercharge: "SPOOKY POP"),
        Brawler_standard(name: "PAM", first_gadget: "PULSE MODULATOR", second_gadget: "SCRAPSUCKER", first_starPower: "MAMA'S HUG", second_starPower: "MAMA'S SQUEEZE", hypercharge: ""),
        Brawler_standard(name: "BERRY", first_gadget: "FRIENDSHIP IS GREAT", second_gadget: "HEALTHY ADDITIVES", first_starPower: "FLOOR IS FINE", second_starPower: "MAKING A MESS", hypercharge: "Double Scoops"),
        Brawler_standard(name: "MAX", first_gadget: "PHASE SHIFTER", second_gadget: "SNEAKY SNEAKERS", first_starPower: "SUPER CHARGED", second_starPower: "RUN N GUN", hypercharge: "UNLIMITED ENERGY"),
        Brawler_standard(name: "BYRON", first_gadget: "SHOT IN THE ARM", second_gadget: "BOOSTER SHOTS", first_starPower: "MALAISE", second_starPower: "INJECTION", hypercharge: ""),
        Brawler_standard(name: "RUFFS", first_gadget: "TAKE COVER", second_gadget: "AIR SUPPORT", first_starPower: "AIR SUPERIORITY", second_starPower: "FIELD PROMOTION", hypercharge: "THE GOODEST BOY"),
        Brawler_standard(name: "GRAY", first_gadget: "WALKING CANE", second_gadget: "GRAND PIANO", first_starPower: "FAKE INJURY", second_starPower: "NEW PERSPECTIVE", hypercharge: "Another Dimention"),
        Brawler_standard(name: "DOUG", first_gadget: "DOUBLE SAUSAGE", second_gadget: "EXTRA MUSTARD", first_starPower: "FAST FOOD", second_starPower: "SELF SERVICE", hypercharge: ""),
        Brawler_standard(name: "KIT", first_gadget: "CARDBOARD BOX", second_gadget: "CHEESEBURGER", first_starPower: "POWER HUNGRY", second_starPower: "OVERLY ATTACHED", hypercharge: ""),
        Brawler_standard(name: "JAE-YONG", first_gadget: "WEEKEND WARRIOR", second_gadget: "TIME FOR A SLOW SONG", first_starPower: "THE CROWD GOES MILD", second_starPower: "EXTRA HIGH NOTE", hypercharge: ""),
    ]
    
    @Published var controller_brawlers_standard = [
        Brawler_standard(name: "JESSIE", first_gadget: "SPARK PLUG", second_gadget: "RECOIL SPRING", first_starPower: "ENERGIZE", second_starPower: "SHOCKY", hypercharge: "SCRAPPY 2.0"),
        Brawler_standard(name: "PENNY", first_gadget: "SALTY BARREL", second_gadget: "TRUSTY SPYGLASS", first_starPower: "HEAVY COFFERS", second_starPower: "MASTER BLASTER", hypercharge: "NEW LOBBER"),
        Brawler_standard(name: "BO", first_gadget: "SUPER TOTEM", second_gadget: "TRIPWIRE", first_starPower: "CIRCLING EAGLE", second_starPower: "SNARE A BEAR", hypercharge: "CATCH A BEAR"),
        Brawler_standard(name: "EMZ", first_gadget: "FRIENDZONER", second_gadget: "ACID SPRAY", first_starPower: "BAD KARMA", second_starPower: "HYPE", hypercharge: "OVERERHYPED HAZE"),
        Brawler_standard(name: "GRIFF", first_gadget: "PIGGY BANK", second_gadget: "COIN SHOWER", first_starPower: "KEEP THE CHANGE", second_starPower: "BUSINESS RESILIENCE", hypercharge: "TAX REBATE"),
        Brawler_standard(name: "GALE", first_gadget: "SPRING EJECTOR", second_gadget: "TWISTER", first_starPower: "BLUSTERY BLOW", second_starPower: "FREEZING SNOW", hypercharge: "BLIZZARD"),
        Brawler_standard(name: "MEEPLE", first_gadget: "MANSIONS OF MEEPLE", second_gadget: "RAGEQUIT", first_starPower: "DO NOT PASS GO", second_starPower: "RULE BENDING", hypercharge: ""),
        Brawler_standard(name: "GENE", first_gadget: "LAMP BLOWOUT", second_gadget: "VENGEFUL SPIRITS", first_starPower: "MAGIC PUFFS", second_starPower: "SPIRIT SLAP", hypercharge: "HYPER HAND"),
        Brawler_standard(name: "MR. P", first_gadget: "SERVICE BELL", second_gadget: "PORTER REINFORCEMENTS", first_starPower: "HANDLE WITH CARE", second_starPower: "REVOLVING DOOR", hypercharge: "SUPER PORTERS! ASSEMBLE!"),
        Brawler_standard(name: "SQUEAK", first_gadget: "WINDUP", second_gadget: "RESIDUE", first_starPower: "CHAIN REACTION", second_starPower: "SUPER STICKY", hypercharge: "BOUNCY BLOB"),
        Brawler_standard(name: "LOU", first_gadget: "ICE BLOCK", second_gadget: "CRYO SYRUP", first_starPower: "SUPERCOOL", second_starPower: "HYPOTHERMIA", hypercharge: "SLUSHIE STORM"),
        Brawler_standard(name: "OTIS", first_gadget: "DORMANT STAR", second_gadget: "PHAT SPLATTER", first_starPower: "STENCIL GLUE", second_starPower: "INK REFILLS", hypercharge: "SILENT STUNNER"),
        Brawler_standard(name: "WILLOW", first_gadget: "SPELLBOUND", second_gadget: "DIVE", first_starPower: "LOVE IS BLIND", second_starPower: "OBSESSION", hypercharge: "PSYCHOC SAFETY"),
        Brawler_standard(name: "CHUCK", first_gadget: "REROUTING", second_gadget: "GHOST TRAIN", first_starPower: "PIT STOP", second_starPower: "TICKETS PLEASE!", hypercharge: ""),
        Brawler_standard(name: "CHARLIE", first_gadget: "SPIDERS", second_gadget: "PERSONAL SPACE", first_starPower: "DIGESTIVE", second_starPower: "SLIMY", hypercharge: "PESTILENCE"),
        Brawler_standard(name: "SANDY", first_gadget: "SLEEP STIMULATOR", second_gadget: "SWEET DREAMS", first_starPower: "RUDE SANDS", second_starPower: "HEALING WINDS", hypercharge: "SWIFT WINDS"),
        Brawler_standard(name: "AMBER", first_gadget: "FIRE STARTERS", second_gadget: "DANCING FLAMES", first_starPower: "WILD FLAMES", second_starPower: "SCORCHIN' SIPHON", hypercharge: "OIL SPILL"),
        Brawler_standard(name: "FINX", first_gadget: "BACK TO THE FINXTURE", second_gadget: "NO ESCAPE", first_starPower: "HIEROGLYPH HALT", second_starPower: "PRIMER", hypercharge: ""),
        
    ]
    
    @Published var damage_dealers_brawlers_standard = [
        Brawler_standard(name: "SHELLY", first_gadget: "FAST FORWARD", second_gadget: "CLAY PIGEONS", first_starPower: "SHELL SHOCK", second_starPower: "BAND-AID", hypercharge: "DOUBLE BARREL"),
        Brawler_standard(name: "NITA", first_gadget: "BEAR PAWS", second_gadget: "FAUX FUR", first_starPower: "BEAR WITH ME", second_starPower: "HYPER BEAR", hypercharge: "HYPERBEARING"),
        Brawler_standard(name: "COLT", first_gadget: "SPEEDLOADER", second_gadget: "SILVER BULLET", first_starPower: "SLICK BOOTS", second_starPower: "MAGNUM SPECIAL", hypercharge: "DUAL WIELDING"),
        Brawler_standard(name: "8-BIT", first_gadget: "CHEAT CARTRIDGE", second_gadget: "EXTRA CREDITS", first_starPower: "BOOSTED BOOSTER", second_starPower: "PLUGGED IN", hypercharge: "AIMBOT"),
        Brawler_standard(name: "RICO", first_gadget: "MULTIBALL LAUNCHER", second_gadget: "BOUNCY CASTLE", first_starPower: "SUPER BOUNCY", second_starPower: "ROBO RETREAT", hypercharge: "TRICK SHOT KING"),
        Brawler_standard(name: "CARL", first_gadget: "HEAT EJECTOR", second_gadget: "FLYING HOOK", first_starPower: "POWER THROW", second_starPower: "PROTECTIVE PIROUETTE", hypercharge: "FLAME SPIN"),
        Brawler_standard(name: "COLETTE", first_gadget: "NA-AH!", second_gadget: "GOTCHA!", first_starPower: "PUSH IT", second_starPower: "MASS TAX", hypercharge: "TEEN SPIRIT"),
        Brawler_standard(name: "LOLA", first_gadget: "FREEZE FRAME", second_gadget: "STUNT DOUBLE", first_starPower: "IMPROVISE", second_starPower: "SEALED WITH A KISS", hypercharge: "INFLATED EGO"),
        Brawler_standard(name: "PEARL", first_gadget: "OVERCOOKED", second_gadget: "MADE WITH LOVE", first_starPower: "HEAT RETENTION", second_starPower: "HEAT SHIELD", hypercharge: "PYROLITIC"),
        Brawler_standard(name: "TARA", first_gadget: "PSYCHIC ENHANCER", second_gadget: "SUPPORT FROM BEYOND", first_starPower: "BLACK PORTAL", second_starPower: "HEALING SHADE", hypercharge: "SUPERMASSIVE"),
        Brawler_standard(name: "EVE", first_gadget: "GOTTA GO!", second_gadget: "MOTHERLY LOVE", first_starPower: "UNNATURAL ORDER", second_starPower: "HAPPY SURPRISE", hypercharge: "Generations"),
        Brawler_standard(name: "R-T", first_gadget: "OUT OF LINE", second_gadget: "HACKS!", first_starPower: "QUICK MATHS", second_starPower: "RECORDING", hypercharge: ""),
        Brawler_standard(name: "CLANCY", first_gadget: "SNAPPY SHOOTING", second_gadget: "TACTICAL RETREAT", first_starPower: "RECON", second_starPower: "PUMPING UP", hypercharge: "RECALL OF DUTY"),
        Brawler_standard(name: "MOE", first_gadget: "DODGY DIGGING", second_gadget: "RAT RACE", first_starPower: "SKIPPING STONES", second_starPower: "SPEEDING TICKET", hypercharge: ""),
        Brawler_standard(name: "SPIKE", first_gadget: "POPPING PINCUSHION", second_gadget: "LIFE PLANT", first_starPower: "FERTILIZE", second_starPower: "CURVEBALL", hypercharge: "BLOOMING SEASON"),
        Brawler_standard(name: "SURGE", first_gadget: "POWER SURGE", second_gadget: "POWER SHIELD", first_starPower: "TO THE MAX!", second_starPower: "SERVE ICE COLD", hypercharge: "LEVEL 5"),
        Brawler_standard(name: "CHESTER", first_gadget: "SPICY DICE", second_gadget: "CANDY BEANS", first_starPower: "SINGLE BELL'O'MANIA", second_starPower: "SNEAK PEEK", hypercharge: "CRUNCHY, CHEWY, GOOEY"),
        Brawler_standard(name: "LUMI", first_gadget: "INFERNAL FLAMES", second_gadget: "GRIM AND FROSTBITTEN", first_starPower: "42% BURNT", second_starPower: "HALF TIME", hypercharge: ""),
    ]
    
    @Published var marksmen_brawlers_standard = [
        Brawler_standard(name: "BROCK", first_gadget: "ROCKET LACES", second_gadget: "ROCKET FUEL", first_starPower: "MORE ROCKETS!", second_starPower: "ROCKET NO. 4", hypercharge: "ROCKET BARRAGE"),
        Brawler_standard(name: "NANI", first_gadget: "WARPIN' TIME", second_gadget: "RETURN TO SENDER", first_starPower: "AUTOFOCUS", second_starPower: "TEMPERED STEEL", hypercharge: "BIG PEEP"),
        Brawler_standard(name: "MANDY", first_gadget: "CARAMELIZE", second_gadget: "COOKIE CRUMBS", first_starPower: "IN MY SIGHTS", second_starPower: "HARD CANDY", hypercharge: "SUGAR FOR ALL!"),
        Brawler_standard(name: "MAISIE", first_gadget: "DISENGAGE!", second_gadget: "FINISH THEM!", first_starPower: "PINPOINT PRECISION", second_starPower: "TREMORS", hypercharge: "AFTERMATH"),
        Brawler_standard(name: "BELLE", first_gadget: "NEST EGG", second_gadget: "REVERSE POLARITY", first_starPower: "POSITIVE FEEDBACK", second_starPower: "GROUNDED", hypercharge: "MAGNETIC"),
        Brawler_standard(name: "BONNIE", first_gadget: "SUGAR RUSH", second_gadget: "CRASH TEST", first_starPower: "BLACK POWDER", second_starPower: "WISDOM TOOTH", hypercharge: ""),
        Brawler_standard(name: "BEA", first_gadget: "HONEY MOLASSES", second_gadget: "RATTLED HIVE", first_starPower: "INSTA BEALOAD", second_starPower: "HONEYCOMB", hypercharge: "PROTECT THE QUEEN"),
        Brawler_standard(name: "ANGELO", first_gadget: "STINGING FLIGHT", second_gadget: "MASTER FLETCHER", first_starPower: "EMPOWER", second_starPower: "FLOW", hypercharge: "IN MY ELEMENT"),
        Brawler_standard(name: "JANET", first_gadget: "DROP THE BASS", second_gadget: "BACKSTAGE PASS", first_starPower: "STAGE VIEW", second_starPower: "VOCAL WARM UP", hypercharge: "Magnus Opus"),
        Brawler_standard(name: "PIPER", first_gadget: "AUTO AIMER", second_gadget: "HOMEMADE RECIPE", first_starPower: "AMBUSH", second_starPower: "SNAPPY SNIPING", hypercharge: "BOPPIN'"),
    ]
    
    @Published var throw_brawlers_standard = [
        Brawler_standard(name: "BARLEY", first_gadget: "STICKY SYRUP MIXER", second_gadget: "HERBAL TONIC", first_starPower: "MEDICAL USE", second_starPower: "EXTRA NOXIOUS", hypercharge: "BOTTLE-UP RAGE"),
        Brawler_standard(name: "DYNAMIKE", first_gadget: "FIDGET SPINNER", second_gadget: "SATCHEL CHARGE", first_starPower: "DYNA-JUMP", second_starPower: "DEMOLITION", hypercharge: "BOOMER"),
        Brawler_standard(name: "TICK", first_gadget: "MINE MANIA", second_gadget: "LAST HURRAH", first_starPower: "WELL OILED", second_starPower: "AUTOMA-TICK RELOAD", hypercharge: "HEAD STRONG"),
        Brawler_standard(name: "GROM", first_gadget: "WATCHTOWER", second_gadget: "RADIO CHECK", first_starPower: "FOOT PATROL", second_starPower: "X-FACTOR", hypercharge: "GROM BOOM GOSS BOOM"),
        Brawler_standard(name: "LARRY & LAWRIE", first_gadget: "ORDER: SWAP", second_gadget: "ORDER: FALL BACK", first_starPower: "PROTOCOL: PROTECT", second_starPower: "PROTOCOL: ASSIST", hypercharge: ""),
        Brawler_standard(name: "SPROUT", first_gadget: "GARDEN MULCHER", second_gadget: "TRANSPLANT", first_starPower: "OVERGROWTH", second_starPower: "PHOTOSYNTHESIS", hypercharge: "THORNS"),
        Brawler_standard(name: "JUJU", first_gadget: "VOODOO CHILE", second_gadget: "ELEMENTALIST", first_starPower: "GUARDED GRIS-GRIS", second_starPower: "NUMBING NEEDLES", hypercharge: ""),
    ]
    
    @Published var all_brawlers_standard: [Brawler_standard] = []
    
    init() {
        all_brawlers_standard = tanker_brawlers_standard + assassin_brawlers_standard + supporter_brawlers_standard  + controller_brawlers_standard + damage_dealers_brawlers_standard + marksmen_brawlers_standard + throw_brawlers_standard
    }
    
    func judgeGear(gears: [Gear], gear: String) -> Bool {
        
        for g in gears {
            if g.name == gear {
                return true
            }
        }
        return false
        
    }
    
    func judgeGadget(gadgets: [Gadget], gadget: String) -> Bool {
        
        for g in gadgets {
            if g.name == gadget {
                return true
            }
        }
        return false
    }
    
    func judgeStarPower(starPowers: [StarPower], starPower: String) -> Bool {
        
        for s in starPowers {
            if s.name == starPower {
                return true
            }
        }
        return false
    }
    
    func judgeHypercharge(_ hypercharge: String) -> Bool {
        let key = "hyperchargeArray"
        let array = UserDefaults.standard.stringArray(forKey: key) ?? []
        
        if array.contains(hypercharge) {
            return true
        } else {
            return false
        }
    }
    
    func addHyperchargeArray(_ hypercharge: String) {
        let key = "hyperchargeArray"
        
        var array = UserDefaults.standard.stringArray(forKey: key) ?? []
        
        if !array.contains(hypercharge) {
            array.append(hypercharge)
            UserDefaults.standard.set(array, forKey: key)
        }
    }
    
    func removeHyperchargeArray(_ hypercharge: String) {
        let key = "hyperchargeArray"
        
        var array = UserDefaults.standard.stringArray(forKey: key) ?? []
        
        if let index = array.firstIndex(of: hypercharge) {
            array.remove(at: index)
            UserDefaults.standard.set(array, forKey: key)
        }
    }
    
    
    func calculatePP(brawler:Brawler?, brawler_standard: Brawler_standard) -> Int {
        if brawler?.name == "" || brawler?.power == 1 {
            return 1440+890+550+340+210+130+80+50+30+20
        } else if brawler?.power == 2 {
            return 1440+890+550+340+210+130+80+50+30
        } else if brawler?.power == 3 {
            return 1440+890+550+340+210+130+80+50
        } else if brawler?.power == 4 {
            return 1440+890+550+340+210+130+80
        } else if brawler?.power == 5 {
            return 1440+890+550+340+210+130
        } else if brawler?.power == 6 {
            return 1440+890+550+340+210
        } else if brawler?.power == 7 {
            return 1440+890+550+340
        } else if brawler?.power == 8 {
            return 1440+890+550
        } else if brawler?.power == 9 {
            return 1440+890
        } else if brawler?.power == 10 {
            return 1440
        } else if brawler?.power == 11 {
           return 0
       }
        return 0
    }
    
    func calculateCredit(brawler:Brawler?, brawler_standard: Brawler_standard) -> Int {
        if brawler?.name == "" {
            if rare.contains(brawler_standard.name) {
                return 160
            } else if super_rare.contains(brawler_standard.name) {
                return 430
            } else if epic.contains(brawler_standard.name) {
                return 925
            } else if mythic.contains(brawler_standard.name) {
                return 1900
            } else if legendary.contains(brawler_standard.name) {
                return 3800
            } else if ultra_legendary.contains(brawler_standard.name) {
                return 5500
            }
        }
        return 0
    }
    
    func calculateCoin(brawler: Brawler?, brawler_standard: Brawler_standard) -> Int {
        var coin = 0
        
        if brawler != nil {
            
            //하이퍼차지 계산
            let key = "hyperchargeArray"
            let array = UserDefaults.standard.stringArray(forKey: key) ?? []
            
            if brawler_standard.hypercharge != "" {
                if !array.contains(brawler_standard.hypercharge) {
                    coin += 5000
                }
            }
            
            //레벨 계산
            let powerCoins = [2800, 1875, 1250, 800, 480, 290, 140, 75, 35, 20]
            if let power = brawler?.power, power >= 1 {
                coin += powerCoins.prefix(11 - power).reduce(0, +)
            } else if brawler?.name == "" {
                coin += powerCoins.prefix(11).reduce(0, +)
            }
            
            //가젯, 스파 계산
            if brawler != nil {
                if !brawler!.gadgets.contains(where: { $0.name == brawler_standard.first_gadget}) {
                    coin += 1000
                }
                if !brawler!.gadgets.contains(where: { $0.name == brawler_standard.second_gadget}) {
                    coin += 1000
                }
                if !brawler!.starPowers.contains(where: { $0.name == brawler_standard.first_starPower}) {
                    coin += 2000
                }
                if !brawler!.starPowers.contains(where: { $0.name == brawler_standard.second_starPower}) {
                    coin += 2000
                }
            }
            
            
            //기어 계산
            //신화 기어 계산
            if mythic_gear_brawlers.contains(brawler!.name) { //신화 기어를 가지고 있는 브롤러
                if !mythic_gear_name.contains(where: { gearName in
                    brawler!.gears.contains { $0.name == gearName }
                }) {
                    coin += 2000
                }
            }
            
            //영웅 기어 계산
            if reload_speed_gear_brawlers.contains(brawler!.name) {
                if !brawler!.gears.contains(where: { $0.name == "RELOAD SPEED" }) {
                    coin += 1500
                }
            }
            if super_charge_gear_brawlers.contains(brawler!.name) {
                if !brawler!.gears.contains(where: { $0.name == "SUPER CHARGE"}) {
                    coin += 1500
                }
            }
            if pet_power_gear_brawlers.contains(brawler!.name) {
                if !brawler!.gears.contains(where: { $0.name == "PET POWER"}) {
                    coin += 1500
                }
            }
            
            //초희귀 기어 계산
            for gear in gear_names {
                if !brawler!.gears.contains(where: { $0.name == gear}) {
                    coin += 1000
                }
            }
        }
        return coin
    }
    
    
    
    
    
    
    
}


struct Brawler_standard: Equatable {
    let id: UUID = UUID() // UUID를 자동 생성
    var name:String
    var first_gadget:String
    var second_gadget:String
    var first_starPower:String
    var second_starPower:String
    var hypercharge:String
}
