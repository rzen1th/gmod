AddCSLuaFile()

SWEP.PrintName	= "EZ Fortification Kit"

SWEP.Author		= "Jackarunda, TheOnly8Z"
SWEP.Purpose	= "FORTIFY FORTIFY FORTIFY"

SWEP.Spawnable	= true
SWEP.UseHands	= true
SWEP.DrawAmmo	= false
SWEP.DrawCrosshair=false

SWEP.ViewModel	= "models/weapons/c_crowbar.mdl"
SWEP.WorldModel	= "models/props_junk/shovel01a.mdl"

SWEP.ViewModelFOV	= 52
SWEP.Slot			= 0
SWEP.SlotPos		= 5

SWEP.InstantPickup=true -- Fort Fights compatibility

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "none"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.ShowViewModel = true
SWEP.ShowWorldModel=false

SWEP.ViewModelBoneMods = {
	["cbar"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) }
}

SWEP.VElements = {
	["shovel"] = { type = "Model", model = "models/props_junk/shovel01a.mdl", bone = "cbar", rel = "", pos = Vector(0, 0, 0), angle = Angle(0, 90, -90), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
SWEP.WElements = {
	["shovel"] = { type = "Model", model = "models/props_junk/shovel01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4, 1, -5), angle = Angle(0, 180, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

-- TODO Move this elsewhere
JMod_Fortifications = {
	[1] = {
		name = "Sandbag Corner",
		model = "models/props_fortifications/sandbags_corner1.mdl",
		ang = Angle(0,180,0),
		mass = 100,
		fixed = true,
		cost = {organic = 30}
	},
	[2] = {
		name = "Sandbag Corner Tall",
		model = "models/props_fortifications/sandbags_corner1_tall.mdl",
		ang = Angle(0,180,0),
		mass = 150,
		fixed = true,
		cost = {organic = 40}
	},
	[3] = {
		name = "Large Sandbag Corner",
		model = "models/props_fortifications/sandbags_corner2.mdl",
		ang = Angle(0,180,0),
		mass = 200,
		fixed = true,
		cost = {organic = 60}
	},
	[4] = {
		name = "Large Sandbag Corner - Tall",
		model = "models/props_fortifications/sandbags_corner2_tall.mdl",
		ang = Angle(0,180,0),
		mass = 300,
		fixed = true,
		cost = {organic = 80}
	},
	[5] = {
		name = "Short Sandbag Line",
		model = "models/props_fortifications/sandbags_line1.mdl",
		ang = Angle(0,180,0),
		mass = 100,
		fixed = true,
		cost = {organic = 50}
	},
	[6] = {
		name = "Short Sandbag Line - Tall",
		model = "models/props_fortifications/sandbags_line1_tall.mdl",
		ang = Angle(0,180,0),
		mass = 150,
		fixed = true,
		cost = {organic = 60}
	},
	[7] = {
		name = "Long Sandbag Line",
		model = "models/props_fortifications/sandbags_line2.mdl",
		ang = Angle(0,180,0),
		mass = 200,
		fixed = true,
		cost = {organic = 80}
	},
	[8] = {
		name = "Long Sandbag Line - Tall",
		model = "models/props_fortifications/sandbags_line2_tall.mdl",
		ang = Angle(0,180,0),
		mass = 300,
		fixed = true,
		cost = {organic = 100}
	},
	[9] = {
		name = "Dragon's Teeth - Small",
		model = "models/props_fortifications/dragonsteeth_small.mdl",
		mass = 300,
		fixed = true,
		cost = {stone = 30, metal = 10}
	},
	[10] = {
		name = "Dragon's Teeth - Large",
		model = "models/props_fortifications/dragonsteeth_large.mdl",
		mass = 500,
		fixed = true,
		cost = {stone = 50, metal = 10}
	},
	[11] = {
		name = "Concrete Barrier",
		model = "models/props_c17/concrete_barrier001a.mdl",
		mass = 400,
		fixed = true,
		cost = {stone = 80}
	},
	[12] = {
		name = "Double Blast Door",
		model = "models/props_lab/blastdoor001c.mdl",
		mass = 200,
		fixed = false,
		cost = {metal = 50}
	},
	[13] = {
		name = "Wooden Door Barricade",
		model = "models/mosi/fallout4/props/fortifications/doorbarricade.mdl",
		mass = 50,
		fixed = false,
		cost = {wood = 40}
	},
	[14] = {
		name = "Junk Wall",
		model = "models/mosi/fallout4/props/fortifications/junkwall02.mdl",
		pos = Vector(0, 0, -10),
		mass = 200,
		fixed = true,
		cost = {wood = 50, metal = 50}
	},
	[15] = {
		name = "Junk Doorway",
		model = "models/mosi/fallout4/props/fortifications/junkwalldoorway.mdl",
		pos = Vector(0, 0, 	-10),
		mass = 180,
		fixed = true,
		cost = {wood = 30, metal = 40}
	},
	
}

function SWEP:SetupDataTables()
	self:NetworkVar("Int",0,"SelectedBuild")
	self:NetworkVar("String",0,"Msg")
	self:NetworkVar("Float",0,"Rotation")
end

if SERVER then

	for _, v in pairs(JMod_Fortifications) do
		util.PrecacheModel(v.model)
	end

	net.Receive("JMod_EZFortKit", function(len, ply)
		local val = net.ReadInt(8)
		if IsValid(ply:GetWeapon("wep_jack_gmod_ezfortkit")) then
			ply:GetWeapon("wep_jack_gmod_ezfortkit"):SwitchSelectedBuild(val)
		end
	end)
	
	hook.Add("PlayerTick", "JMod_EZFortKit_Ghost", function(ply, mv)
		local wep = ply:GetActiveWeapon()
		local ang = ply:GetAngles()
		local tr = ply:GetEyeTrace()

		if IsValid(ply) and ply:Alive() and IsValid(wep) and wep:GetClass() == "wep_jack_gmod_ezfortkit" and wep:GetSelectedBuild() > 0 then
			if not IsValid(ply.fortkitGhost) then
				ply.fortkitGhost = ents.Create("prop_physics")
				if IsValid(ply.fortkitGhost) then
					ply.fortkitGhost:SetAngles(Angle(0, ply:EyeAngles().y - 180, 0) + (JMod_Fortifications[wep:GetSelectedBuild()].ang or Angle(0,0,0)))
					ply.fortkitGhost:SetPos(tr.HitPos - tr.HitNormal * ply.fortkitGhost:OBBMins().z + (JMod_Fortifications[wep:GetSelectedBuild()].pos or Vector(0,0,0)))
					ply.fortkitGhost:SetColor(Color(46, 204, 113, 150))
					ply.fortkitGhost:SetModel(JMod_Fortifications[wep:GetSelectedBuild()].model)
					ply.fortkitGhost:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)
					ply.fortkitGhost:SetRenderMode(RENDERMODE_TRANSALPHA)
					ply.fortkitGhost:Spawn()
				else
					ply.fortkitGhost = nil
				end
			elseif IsValid(ply.fortkitGhost) then
				if ply.fortkitGhost:GetModel() != JMod_Fortifications[wep:GetSelectedBuild()].model then
					ply.fortkitGhost:SetModel(JMod_Fortifications[wep:GetSelectedBuild()].model)
				end
				ply.fortkitGhost:SetPos(tr.HitPos - tr.HitNormal * ply.fortkitGhost:OBBMins().z + (JMod_Fortifications[wep:GetSelectedBuild()].pos or Vector(0,0,0)))
				ply.fortkitGhost:SetAngles(Angle(0, ply:EyeAngles().y, 0) + (JMod_Fortifications[wep:GetSelectedBuild()].ang or Angle(0,0,0)))
				if tr.HitPos:Distance(ply:GetPos()) >= 200 then
					ply.fortkitGhost:SetColor(Color(255, 255, 255, 0))
				elseif ply.fortkitGhost:GetColor().a == 0 then
					ply.fortkitGhost:SetColor(Color(45, 200, 110, 150))
				end
			end
		elseif ply.fortkitGhost != nil and IsValid(ply.fortkitGhost) then
			ply.fortkitGhost:Remove()
			ply.fortkitGhost = nil
		end
	end)
end

function SWEP:Initialize()
	self:SetHoldType("knife")
	self:SCKInitialize()
	self:Deploy()
	self.NextSwitch = 0
end

function SWEP:Deploy()

end

function SWEP:Holster()
	return true
end

function SWEP:OnRemove()
end

function SWEP:CanSee(ent)
	if(ent:GetNoDraw())then return end
	return not util.TraceLine({
		start=self:GetPos(),
		endpos=ent:GetPos(),
		filter={self,self.Owner,ent},
		mask=MASK_SOLID_BRUSHONLY
	}).Hit
end

function SWEP:CountMaterialInRange()
	local Results={}
	for k,obj in pairs(ents.FindInSphere(self:GetPos(),150))do
		if((obj:GetClass() == "ent_jack_gmod_ezmatcube")and(self:CanSee(obj)))then
			local Typ=obj.MaterialType
			Results[Typ]=(Results[Typ] or 0)+obj:GetPhysicsObject():GetMass()
		end
	end
	return Results
end

function SWEP:HaveMaterialToPerformTask(requirements)
	local RequirementsMet,MaterialInRange=true,self:CountMaterialInRange()
	for typ,amt in pairs(requirements)do
		if(not((MaterialInRange[typ])and(MaterialInRange[typ]>=amt)))then
			RequirementsMet=false
			break
		end
	end
	return RequirementsMet
end

function SWEP:ConsumeMaterialInRange(requirements)
	local AllDone,Attempts,RequirementsRemaining=false,0,table.FullCopy(requirements)
	while not((AllDone)or(Attempts>1000))do
		local TypesNeeded=table.GetKeys(RequirementsRemaining)
		if((TypesNeeded)and(#TypesNeeded>0))then
			local MatTypeToLookFor=TypesNeeded[1]
			local AmountWeNeed=RequirementsRemaining[MatTypeToLookFor]
			local Donor=self:FindMaterialCube(MatTypeToLookFor,1) -- every little bit helps
			if(Donor)then
				local AmountWeCanTake=Donor:GetPhysicsObject():GetMass()
				if(AmountWeNeed>=AmountWeCanTake)then
					Donor:Remove()
					RequirementsRemaining[MatTypeToLookFor]=RequirementsRemaining[MatTypeToLookFor]-AmountWeCanTake
				else
					--Donor:GetPhysicsObject():SetMass(AmountWeCanTake-AmountWeNeed)
					local donorPos = Donor:GetPos()
					Donor:Remove()
					JMod_GenerateMaterial(donorPos, MatTypeToLookFor, AmountWeCanTake-AmountWeNeed)
					RequirementsRemaining[MatTypeToLookFor]=RequirementsRemaining[MatTypeToLookFor]-AmountWeNeed
				end
				if(RequirementsRemaining[MatTypeToLookFor]<=0)then RequirementsRemaining[MatTypeToLookFor]=nil end
			end
		else
			AllDone=true
		end
		Attempts=Attempts+1
	end
end

function SWEP:FindMaterialCube(typ,amt)
	for k,obj in pairs(ents.FindInSphere(self:GetPos(),150))do
		if((obj:GetClass() == "ent_jack_gmod_ezmatcube")and(obj.MaterialType==typ)and(obj:GetPhysicsObject():GetMass()>=amt)and(self:CanSee(obj)))then
			return obj
		end
	end
end

function SWEP:ViewModelDrawn()

	self:SCKViewModelDrawn()
end

function SWEP:DrawWorldModel()
	self:SCKDrawWorldModel()
end

function SWEP:DoAnimation()
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	local vm=self.Owner:GetViewModel()
	vm:SendViewModelMatchingSequence( vm:LookupSequence( "misscenter" .. math.random(1,2) ) )
	self:UpdateNextIdle()
end

function SWEP:UpdateNextIdle()
	local vm=self.Owner:GetViewModel()
	self.NextIdle=CurTime()+vm:SequenceDuration()
end

function SWEP:SwitchSelectedBuild(num)
	if(num>#JMod_Fortifications)then num=0 end
	self:SetSelectedBuild(num)
	if(num>0)then
		local Msg="SELECTED: "..JMod_Fortifications[num].name.." - "
		for typ,amt in pairs(JMod_Fortifications[num].cost)do
			Msg=Msg..tostring(amt).." "..typ.." "
		end
		self:SetMsg(Msg)
	else
		self:SetMsg("")
	end
end

function SWEP:PrimaryAttack()
	if self:GetSelectedBuild() > 0 and IsValid(self.Owner.fortkitGhost) and self.Owner:GetEyeTrace().HitPos:Distance(self.Owner:GetPos()) < 200 then
		
		local tbl = JMod_Fortifications[self:GetSelectedBuild()]
		
		-- TODO check and consume resources
		if !self:HaveMaterialToPerformTask(tbl.cost) then
			self.Owner:PrintMessage(HUD_PRINTCENTER, "Cannot afford - stand near more material")
			self:SetNextPrimaryFire(CurTime() + 1)
			return
		end
		self:ConsumeMaterialInRange(tbl.cost)
	
		local tr = self.Owner:GetEyeTrace()
		local fort = ents.Create("prop_physics")
		fort:SetModel(tbl.model)
		fort:SetAngles(Angle(0, self.Owner:EyeAngles().y, 0) + (tbl.ang or Angle(0,0,0)))
		fort:SetPos(self.Owner:GetEyeTrace().HitPos - self.Owner:GetEyeTrace().HitNormal * self.Owner.fortkitGhost:OBBMins().z + (tbl.pos or Vector(0,0,0)))
		fort.EZnosalvage = true
		fort.EZfortOwner = self.Owner
		fort:Spawn()
		fort:DropToFloor()
		
		local phys = fort:GetPhysicsObject()
		if phys:IsValid() then
			phys:SetMass(tbl.mass)
			if tbl.fixed then
				phys:EnableMotion(false)
				--constraint.Weld(fort,game.GetWorld(),0,0,tbl.mass*10,true,false)
			else
				phys:EnableMotion(false)
				timer.Simple(3, function() if IsValid(fort) and phys:IsValid() then phys:EnableMotion(true) phys:Wake() end end)
			end
		end
		
		self:SwitchSelectedBuild(0)
		self:SetNextPrimaryFire(CurTime() + 3)
	else
		self:DoAnimation()
		self:SetNextPrimaryFire(CurTime() + 1)
	end
end

function SWEP:SecondaryAttack()
	local fort = self.Owner:GetEyeTrace().Entity
	if IsValid(fort) and fort.EZfortOwner == self.Owner then
		fort:Remove()
		self:SetNextSecondaryFire(CurTime() + 1)
	end
end

function SWEP:Reload()
	if(SERVER)then
		local Time=CurTime()
		if(self.Owner:KeyDown(IN_WALK))then
		
		else
			if(self.NextSwitch<Time)then
				self.NextSwitch=Time+.5
				local Build=self:GetSelectedBuild()
				if(Build>0)then
					self:SwitchSelectedBuild(0)
				else
					net.Start("JMod_EZFortKit")
						net.WriteTable(JMod_Fortifications)
						net.WriteEntity(self)
					net.Send(self.Owner)
				end
			end
		end
	end
end

function SWEP:DrawHUD()
	local W,H,Msg=ScrW(),ScrH(),self:GetMsg()
	if((Msg)and(Msg~=""))then
		draw.SimpleTextOutlined(Msg,"Trebuchet24",W*.5,H*.7,Color(255,255,255,150),TEXT_ALIGN_CENTER,TEXT_ALIGN_TOP,3,Color(0,0,0,150))
	end
	draw.SimpleTextOutlined("R: select build item","Trebuchet24",W*.4,H*.7+30,Color(255,255,255,50),TEXT_ALIGN_LEFT,TEXT_ALIGN_TOP,3,Color(0,0,0,50))
	draw.SimpleTextOutlined("LMB: build","Trebuchet24",W*.4,H*.7+60,Color(255,255,255,50),TEXT_ALIGN_LEFT,TEXT_ALIGN_TOP,3,Color(0,0,0,50))
	draw.SimpleTextOutlined("RMB: destroy","Trebuchet24",W*.4,H*.7+90,Color(255,255,255,50),TEXT_ALIGN_LEFT,TEXT_ALIGN_TOP,3,Color(0,0,0,50))
end

-- SCK

function SWEP:SCKHolster()
	if CLIENT and IsValid(self.Owner)then
		local vm=self.Owner:GetViewModel()
		if IsValid(vm)then
			self:ResetBonePositions(vm)
		end
	end
end

function SWEP:SCKInitialize()

	if CLIENT then
	
		// Create a new table for every weapon instance
		self.VElements=table.FullCopy( self.VElements )
		self.WElements=table.FullCopy( self.WElements )
		self.ViewModelBoneMods=table.FullCopy( self.ViewModelBoneMods )

		self:CreateModels(self.VElements) // create viewmodels
		self:CreateModels(self.WElements) // create worldmodels
		
		// init view model bone build function
		if IsValid(self.Owner)then
			local vm=self.Owner:GetViewModel()
			if IsValid(vm)then
				self:ResetBonePositions(vm)
			end
			
			// Init viewmodel visibility
			if(self.ShowViewModel==nil or self.ShowViewModel)then
				if(IsValid(vm))then
					vm:SetColor(Color(255,255,255,255))
				end
			else
				// we set the alpha to 1 instead of 0 because else ViewModelDrawn stops being called
				vm:SetColor(Color(255,255,255,1))
				// ^ stopped working in GMod 13 because you have to do Entity:SetRenderMode(1) for translucency to kick in
				// however for some reason the view model resets to render mode 0 every frame so we just apply a debug material to prevent it from drawing
				vm:SetMaterial("Debug/hsv")
			end
		end
		
	end

end

if(CLIENT)then
	SWEP.vRenderOrder=nil
	function SWEP:SCKViewModelDrawn()
		local vm=self.Owner:GetViewModel()
		if !IsValid(vm)then return end
		
		if(!self.VElements)then return end
		
		self:UpdateBonePositions(vm)

		if(!self.vRenderOrder)then
			
			// we build a render order because sprites need to be drawn after models
			self.vRenderOrder={}

			for k, v in pairs( self.VElements ) do
				if(v.type=="Model")then
					table.insert(self.vRenderOrder, 1, k)
				elseif(v.type=="Sprite" or v.type=="Quad")then
					table.insert(self.vRenderOrder, k)
				end
			end
			
		end

		for k, name in ipairs( self.vRenderOrder ) do
		
			local v=self.VElements[name]
			if(!v)then self.vRenderOrder=nil break end
			if(v.hide)then continue end
			
			local model=v.modelEnt
			local sprite=v.spriteMaterial
			
			if(!v.bone)then continue end
			
			local pos, ang=self:GetBoneOrientation( self.VElements, v, vm )
			
			if(!pos)then continue end
			
			if(v.type=="Model" and IsValid(model))then

				model:SetPos(pos+ang:Forward()*v.pos.x+ang:Right()*v.pos.y+ang:Up()*v.pos.z )
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)

				model:SetAngles(ang)
				//model:SetModelScale(v.size)
				local matrix=Matrix()
				matrix:Scale(v.size)
				model:EnableMatrix( "RenderMultiply", matrix )
				
				if(v.material=="")then
					model:SetMaterial("")
				elseif(model:GetMaterial() != v.material)then
					model:SetMaterial( v.material )
				end
				
				if(v.skin and v.skin != model:GetSkin())then
					model:SetSkin(v.skin)
				end
				
				if(v.bodygroup)then
					for k, v in pairs( v.bodygroup ) do
						if(model:GetBodygroup(k) != v)then
							model:SetBodygroup(k, v)
						end
					end
				end
				
				if(v.surpresslightning)then
					render.SuppressEngineLighting(true)
				end
				
				render.SetColorModulation(v.color.r/255, v.color.g/255, v.color.b/255)
				render.SetBlend(v.color.a/255)
				model:DrawModel()
				render.SetBlend(1)
				render.SetColorModulation(1, 1, 1)
				
				if(v.surpresslightning)then
					render.SuppressEngineLighting(false)
				end
				
			elseif(v.type=="Sprite" and sprite)then
				
				local drawpos=pos+ang:Forward()*v.pos.x+ang:Right()*v.pos.y+ang:Up()*v.pos.z
				render.SetMaterial(sprite)
				render.DrawSprite(drawpos, v.size.x, v.size.y, v.color)
				
			elseif(v.type=="Quad" and v.draw_func)then
				
				local drawpos=pos+ang:Forward()*v.pos.x+ang:Right()*v.pos.y+ang:Up()*v.pos.z
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)
				
				cam.Start3D2D(drawpos, ang, v.size)
					v.draw_func( self )
				cam.End3D2D()

			end
			
		end
		
	end

	SWEP.wRenderOrder=nil
	function SWEP:SCKDrawWorldModel()
		if(self.ShowWorldModel==nil or self.ShowWorldModel)then
			self:DrawModel()
		end
		
		if(!self.WElements)then return end
		
		if(!self.wRenderOrder)then

			self.wRenderOrder={}

			for k, v in pairs( self.WElements ) do
				if(v.type=="Model")then
					table.insert(self.wRenderOrder, 1, k)
				elseif(v.type=="Sprite" or v.type=="Quad")then
					table.insert(self.wRenderOrder, k)
				end
			end

		end
		
		if(IsValid(self.Owner))then
			bone_ent=self.Owner
		else
			// when the weapon is dropped
			bone_ent=self
		end
		
		for k, name in pairs( self.wRenderOrder ) do
		
			local v=self.WElements[name]
			if(!v)then self.wRenderOrder=nil break end
			if(v.hide)then continue end
			
			local pos, ang
			
			if(v.bone)then
				pos, ang=self:GetBoneOrientation( self.WElements, v, bone_ent )
			else
				pos, ang=self:GetBoneOrientation( self.WElements, v, bone_ent, "ValveBiped.Bip01_R_Hand" )
			end
			
			if(!pos)then continue end
			
			local model=v.modelEnt
			local sprite=v.spriteMaterial
			
			if(v.type=="Model" and IsValid(model))then

				model:SetPos(pos+ang:Forward()*v.pos.x+ang:Right()*v.pos.y+ang:Up()*v.pos.z )
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)

				model:SetAngles(ang)
				//model:SetModelScale(v.size)
				local matrix=Matrix()
				matrix:Scale(v.size)
				model:EnableMatrix( "RenderMultiply", matrix )
				
				if(v.material=="")then
					model:SetMaterial("")
				elseif(model:GetMaterial() != v.material)then
					model:SetMaterial( v.material )
				end
				
				if(v.skin and v.skin != model:GetSkin())then
					model:SetSkin(v.skin)
				end
				
				if(v.bodygroup)then
					for k, v in pairs( v.bodygroup ) do
						if(model:GetBodygroup(k) != v)then
							model:SetBodygroup(k, v)
						end
					end
				end
				
				if(v.surpresslightning)then
					render.SuppressEngineLighting(true)
				end
				
				render.SetColorModulation(v.color.r/255, v.color.g/255, v.color.b/255)
				render.SetBlend(v.color.a/255)
				model:DrawModel()
				render.SetBlend(1)
				render.SetColorModulation(1, 1, 1)
				
				if(v.surpresslightning)then
					render.SuppressEngineLighting(false)
				end
				
			elseif(v.type=="Sprite" and sprite)then
				
				local drawpos=pos+ang:Forward()*v.pos.x+ang:Right()*v.pos.y+ang:Up()*v.pos.z
				render.SetMaterial(sprite)
				render.DrawSprite(drawpos, v.size.x, v.size.y, v.color)
				
			elseif(v.type=="Quad" and v.draw_func)then
				
				local drawpos=pos+ang:Forward()*v.pos.x+ang:Right()*v.pos.y+ang:Up()*v.pos.z
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)
				
				cam.Start3D2D(drawpos, ang, v.size)
					v.draw_func( self )
				cam.End3D2D()

			end
			
		end
		
	end

	function SWEP:GetBoneOrientation( basetab, tab, ent, bone_override )
		
		local bone, pos, ang
		if(tab.rel and tab.rel != "")then
			
			local v=basetab[tab.rel]
			
			if(!v)then return end
			
			// Technically, if there exists an element with the same name as a bone
			// you can get in an infinite loop. Let's just hope nobody's that stupid.
			pos, ang=self:GetBoneOrientation( basetab, v, ent )
			
			if(!pos)then return end
			
			pos=pos+ang:Forward()*v.pos.x+ang:Right()*v.pos.y+ang:Up()*v.pos.z
			ang:RotateAroundAxis(ang:Up(), v.angle.y)
			ang:RotateAroundAxis(ang:Right(), v.angle.p)
			ang:RotateAroundAxis(ang:Forward(), v.angle.r)
				
		else
		
			bone=ent:LookupBone(bone_override or tab.bone)

			if(!bone)then return end
			
			pos, ang=Vector(0,0,0), Angle(0,0,0)
			local m=ent:GetBoneMatrix(bone)
			if(m)then
				pos, ang=m:GetTranslation(), m:GetAngles()
			end
			
			if(IsValid(self.Owner) and self.Owner:IsPlayer() and 
				ent==self.Owner:GetViewModel() and self.ViewModelFlip)then
				ang.r=-ang.r // Fixes mirrored models
			end
		
		end
		
		return pos, ang
	end

	function SWEP:CreateModels( tab )

		if(!tab)then return end

		-- Create the clientside models here because Garry says we can't do it in the render hook
		for k, v in pairs( tab ) do
			if(v.type=="Model" and v.model and v.model != "" and (!IsValid(v.modelEnt) or v.createdModel != v.model) and 
					string.find(v.model, ".mdl") and file.Exists (v.model, "GAME") )then
				
				v.modelEnt=ClientsideModel(v.model, RENDER_GROUP_VIEW_MODEL_OPAQUE)
				if(IsValid(v.modelEnt))then
					v.modelEnt:SetPos(self:GetPos())
					v.modelEnt:SetAngles(self:GetAngles())
					v.modelEnt:SetParent(self)
					v.modelEnt:SetNoDraw(true)
					v.createdModel=v.model
				else
					v.modelEnt=nil
				end
				
			elseif(v.type=="Sprite" and v.sprite and v.sprite != "" and (!v.spriteMaterial or v.createdSprite != v.sprite) 
				and file.Exists ("materials/"..v.sprite..".vmt", "GAME"))then
				
				local name=v.sprite.."-"
				local params={ ["$basetexture"]=v.sprite }
				// make sure we create a unique name based on the selected options
				local tocheck={ "nocull", "additive", "vertexalpha", "vertexcolor", "ignorez" }
				for i, j in pairs( tocheck ) do
					if(v[j])then
						params["$"..j]=1
						name=name.."1"
					else
						name=name.."0"
					end
				end

				v.createdSprite=v.sprite
				v.spriteMaterial=CreateMaterial(name,"UnlitGeneric",params)
				
			end
		end
		
	end
	
	local allbones
	local hasGarryFixedBoneScalingYet=false

	function SWEP:UpdateBonePositions(vm)
		
		if self.ViewModelBoneMods then
			
			if(!vm:GetBoneCount())then return end
			
			// !! WORKAROUND !! //
			// We need to check all model names :/
			local loopthrough=self.ViewModelBoneMods
			if(!hasGarryFixedBoneScalingYet)then
				allbones={}
				for i=0, vm:GetBoneCount() do
					local bonename=vm:GetBoneName(i)
					if(self.ViewModelBoneMods[bonename])then 
						allbones[bonename]=self.ViewModelBoneMods[bonename]
					else
						allbones[bonename]={ 
							scale=Vector(1,1,1),
							pos=Vector(0,0,0),
							angle=Angle(0,0,0)
						}
					end
				end
				
				loopthrough=allbones
			end
			// !! ----------- !! //
			
			for k, v in pairs( loopthrough ) do
				local bone=vm:LookupBone(k)
				if(!bone)then continue end
				
				// !! WORKAROUND !! //
				local s=Vector(v.scale.x,v.scale.y,v.scale.z)
				local p=Vector(v.pos.x,v.pos.y,v.pos.z)
				local ms=Vector(1,1,1)
				if(!hasGarryFixedBoneScalingYet)then
					local cur=vm:GetBoneParent(bone)
					while(cur>=0) do
						local pscale=loopthrough[vm:GetBoneName(cur)].scale
						ms=ms*pscale
						cur=vm:GetBoneParent(cur)
					end
				end
				
				s=s*ms
				// !! ----------- !! //
				
				if vm:GetManipulateBoneScale(bone) != s then
					vm:ManipulateBoneScale( bone, s )
				end
				if vm:GetManipulateBoneAngles(bone) != v.angle then
					vm:ManipulateBoneAngles( bone, v.angle )
				end
				if vm:GetManipulateBonePosition(bone) != p then
					vm:ManipulateBonePosition( bone, p )
				end
			end
		else
			self:ResetBonePositions(vm)
		end
		   
	end
	 
	function SWEP:ResetBonePositions(vm)
		
		if(!vm:GetBoneCount())then return end
		for i=0, vm:GetBoneCount() do
			vm:ManipulateBoneScale( i, Vector(1, 1, 1) )
			vm:ManipulateBoneAngles( i, Angle(0, 0, 0) )
			vm:ManipulateBonePosition( i, Vector(0, 0, 0) )
		end
		
	end
end