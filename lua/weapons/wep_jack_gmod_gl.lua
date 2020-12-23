SWEP.Base = "wep_jack_gmod_gunbase"

SWEP.PrintName = "M79"

SWEP.Slot = 4

SWEP.ViewModel = "models/weapons/v_jmod_m79.mdl"
SWEP.WorldModel = "models/weapons/w_jmod_m79.mdl"
SWEP.ViewModelFOV = 70
SWEP.BodyHolsterSlot = "back"
SWEP.BodyHolsterAng = Angle(0,-105,0)
SWEP.BodyHolsterAngL = Angle(0,-75,160)
SWEP.BodyHolsterPos = Vector(1,-14,-11)
SWEP.BodyHolsterPosL = Vector(-2.5,-15,11)
SWEP.BodyHolsterScale = .9

JMod_ApplyAmmoSpecs(SWEP,"40mm Grenade")
SWEP.DamageRand = .1
SWEP.ShootEntity = "ent_jack_gmod_ezprojectilenade"
SWEP.MuzzleVelocity = 3000

SWEP.Primary.ClipSize = 1 -- DefaultClip is automatically set.

SWEP.Recoil = 3

SWEP.Delay = 60 / 100 -- 60 / RPM.
SWEP.Firemodes = {
    {
        Mode = 1,
		PrintName = "SINGLE"
    },
    {
        Mode = 0
    }
}

SWEP.AccuracyMOA = 15 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.

SWEP.Primary.Ammo = "40mm Grenade" -- what ammo type the gun uses

SWEP.FirstShootSound = "snds_jack_gmod/ez_weapons/40mm_grenade.wav"
SWEP.ShootSound = "snds_jack_gmod/ez_weapons/40mm_grenade.wav"
SWEP.DistantShootSound = "snds_jack_gmod/ez_weapons/rifle_far.wav"
SWEP.ShootSoundExtraMult=1

SWEP.MuzzleEffect = "muzzleflash_m79"
SWEP.ShellModel = "models/jhells/shell_9mm.mdl"
SWEP.ShellPitch = 50
SWEP.ShellScale = 7

SWEP.SpeedMult = 1
SWEP.SightedSpeedMult = .85
SWEP.SightTime = .5

SWEP.IronSightStruct = {
    Pos = Vector(-3.15, 0, 1.32),
    Ang = Angle(2.2, 0, -2),
    Magnification = 1.1,
    SwitchToSound = JMod_GunHandlingSounds.aim.inn,
    SwitchFromSound = JMod_GunHandlingSounds.aim.out
}

SWEP.ActivePos = Vector(1, 0, 0)
SWEP.ActiveAng = Angle(1.8, 1.5, -2.5)

SWEP.HolsterPos = Vector(6, -1, -4)
SWEP.HolsterAng = Angle(0, 50, 0)

SWEP.BarrelLength = 30

--[[
idle
reload_tac
draw1
fire
holster
--]]
SWEP.Animations = {
    ["idle"] = {
        Source = "idle",
        Time = 1
    },
    ["draw"] = {
        Source = "draw1",
        Time = 1,
        SoundTable = {{s = JMod_GunHandlingSounds.draw.longgun, t = 0, v=60}},
		Mult=1,
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.35,
    },
    ["fire"] = {
        Source = "fire",
        Time = 0.5
    },
    ["reload_empty"] = {
        Source = "reload_tac",
        Time = 4,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Checkpoints = {24, 42, 59, 71, 89},
        FrameRate = 37,
		Mult=.95,
        LHIK = true,
        LHIKIn = 0.5,
        LHIKOut = 0.5,
		ShellEjectAt = 1.8,
		SoundTable = {
			{s = "snds_jack_gmod/ez_weapons/gl/move.wav", t = .3, v=60},
			{s = "snds_jack_gmod/ez_weapons/gl/open.wav", t = .05, v=65},
			{s = "snds_jack_gmod/ez_weapons/gl/out.wav", t = 1, v=65},
			{s = JMod_GunHandlingSounds.cloth.magpull, t = 1.7, v=60, p=120},
			{s = "snds_jack_gmod/ez_weapons/gl/in.wav", t = 2.3, v=65},
			{s = JMod_GunHandlingSounds.grab, t = 2.9, v=60},
			{s = "snds_jack_gmod/ez_weapons/gl/close.wav", t = 3.25, v=65},
			{s = "snds_jack_gmod/ez_weapons/gl/move.wav", t = 3.3, v=60}
		}
    },
}