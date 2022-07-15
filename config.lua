Config = {}

Config.ESXSHAREDOBJECT = 'esx:getSharedObject'


Config.t1gerKeys = false
Config.T1GER_Shops	= false
Config.DeliveryJobName = "delivery"

-- Buttons:
Config.KeyToManageCompany		= 38		-- Default: [E]
Config.KeyToBuyCompany			= 38		-- Default: [E]	
Config.KeyToLoadJobVehicle		= 38		-- Default: [E]	
Config.KeyToPickUpParcel		= 38		-- Default: [E]	
Config.KeyToPutParcelInVeh		= 38		-- Default: [E]	
Config.KeyToDeliverParcel		= 47		-- Default: [G]	
Config.KeyToTakeParcelFromVeh	= 38		-- Default: [E]		
Config.KeyToReturnJobVehicle	= 38		-- Default: [E]				

-- General Settings:
Config.BuyableCompanyBlip 	    = true		-- Blip to show mechanic shops forsale
Config.PayCompanyWithCash		= true		-- Set to false to pay mech shop with bank
Config.ReciveSoldCompanyCash	= true		-- Set to false to receive bank money on sale of drug lab
Config.SellPercent				= 0.75		-- Means player gets 75% in return from original paid price
Config.CertificatePrice			= 4500		-- Set price to purchase certificate
Config.AddLevelAmount			= 1			-- Set amount of levels added upon completing a job

-- Blip & Marker Settings:
Config.BlipSettings = { enable = true, sprite = 477, display = 4, scale = 0.60 } 
Config.MarkerSettings = { enable = true, drawDist = 10.0, type = 20, scale = {x = 0.7, y = 0.7, z = 0.7}, color = {r = 240, g = 52, b = 52, a = 100} }

-- Job Settings:
Config.DepositInCash 			= true		-- set to false to pay vehicle deposit with bank money
Config.DamagePercent			= 25			-- if job veh body health is decreased more than 5%, then no payout for that specific delivery.
Config.DepositDamage			= 75		-- if vehicle is damaged more than x %, then deposit is not returned.

-- Reward Settings:
Config.Reward = { 
	min = 250,
	max = 500, 
	valueAddition = { [1] = 5, [2] = 10, [3] = 15, [4] = 50 }	-- adds x% to the math.random(min,max), where 1, 2, 3 are levels
}

Config.Companies = {
	[1] = {
		menuPos = {1204.9,-3285.74,5.5},
		price = 125000,
		vehSpawn = {1189.74,-3299.74,5.74,179.85},
		refill = {pos = {1198.04,-3289.74,5.07}, marker = {drawDist = 20.0, type = 27, scale = {x=3.0,y=3.0,z=1.0}, color = {r=220,g=60,b=60,a=100}}},
		cargoMarker = {drawDist = 20.0, type = 27, scale = {x=0.3,y=0.3,z=0.3}, color = {r=220,g=60,b=60,a=100}},
		cargo = {
			[1] = {1195.69,-3284.53,5.5},
			[2] = {1198.73,-3284.07,5.5},
			[3] = {1203.23,-3280.58,5.5},
			[4] = {1211.02,-3279.76,5.5},
			[5] = {1207.16,-3276.75,5.5},
		},
		trailerSpawn = {1189.36,-3290.73,5.74,181.31},
		forklift = {pos = {1197.1,-3293.34,4.96,359.97}, model = "forklift"}
	},
	[2] = {
		menuPos = {1014.3,-2294.96,30.52},
		price = 265000,
		vehSpawn = {1019.25,-2322.05,30.75,354.0},
		refill = {pos = {1009.3,-2329.27,30.52}, marker = {drawDist = 20.0, type = 27, scale = {x=3.0,y=3.0,z=1.0}, color = {r=220,g=60,b=60,a=100}}},
		cargoMarker = {drawDist = 10.0, type = 2, scale = {x=0.3,y=0.3,z=0.3}, color = {r=220,g=60,b=60,a=100}},
		cargo = {
			[1] = {1013.08,-2316.882,30.52},
			[2] = {1011.57,-2309.68,30.52},
			[3] = {1016.15,-2321.15,30.52},
			[4] = {1009.03,-2321.42,30.52},
			[5] = {1021.34,-2307.34,30.52},
		},
		trailerSpawn = {1018.18,-2334.69,30.75,354.3},
		forklift = {pos = {1007.06,-2325.83,29.97,270.0}, model = "forklift"}
	},
}

-- Marker Settings for delivery spots
Config.DeliveryMarkerSpots = {type = 2, scale = {x=0.35,y=0.35,z=0.35}, color = {r=220,g=60,b=60,a=100} }

Config.JobValues = {
	[1] = {
		label = "Low", level = 0, certificate = false,
		vehicles = {
			[1] = {name = "Surfer 2", model = "surfer2", deposit = 500},
			[2] = {name = "Speedo", model = "speedo", deposit = 1000},
			[3] = {name = "Burrito 3", model = "burrito3", deposit = 1500},
			[4] = {name = "Rumpo", model = "rumpo", deposit = 2000}
		}
	},
	[2] = {
		label = "Medium", level = 20, certificate = false,
		vehicles = {
			[1] = {name = "Boxville 2", model = "boxville2", deposit = 1500},
			[2] = {name = "Boxville 4", model = "boxville4", deposit = 3000}
		}
	},
	[3] = {
		label = "High", level = 50, certificate = true,
		vehicles = { 
			[1] = {name = "Kenworth 523b", model = "ken523b", deposit = 1500},
			[2] = {name = "Kenworth W900", model = "W900", deposit = 3000},
			[3] = {name = "Phantom", model = "phantom", deposit = 4500},
		}
	},
	[4] = {
		label = "Shops", level = 0, certificate = false,
		vehicles = { 
			[1] = {name = "Speedo", model = "speedo", deposit = 1000},
			[2] = {name = "Burrito 3", model = "burrito3", deposit = 1500},
			[3] = {name = "Boxville 2", model = "boxville2", deposit = 2500},
			[4] = {name = "Boxville 4", model = "boxville4", deposit = 3000},
		}
	},
}

Config.ParcelProp = "prop_cs_cardbox_01"		-- set prop type for low value jobs
Config.LowValueJobs = {
	[1] = {pos = {85.63,-1959.32,21.12}, done = false},
	[2] = {pos = {-14.09,-1442.06,31.1}, done = false},
	[3] = {pos = {334.67,-2057.93,20.94}, done = false},
	[4] = {pos = {479.67,-1736.01,29.15}, done = false},
	[5] = {pos = {-1075.48,-1645.37,4.5}, done = false},
	[6] = {pos = {-1132.46,-1455.88,4.87}, done = false},
	[7] = {pos = {-951.8,-1078.59,2.15}, done = false},
	[8] = {pos = {-911.93,-1511.76,5.02}, done = false},
	[9] = {pos = {-1112.03,-902.51,3.6}, done = false},
	[10] = {pos = {976.25,-580.07,59.64}, done = false},
	[11] = {pos = {1303.06,-527.99,71.46}, done = false}
}

Config.MedValueJobs = {
	[1] = {
		name = "Clothing",
		prop = "prop_tshirt_box_01",
		deliveries = {
			[1] = {pos = {79.34,-1389.52,29.38}, done = false},
			[2] = {pos = {-1198.24,-774.43,17.32}, done = false},
			[3] = {pos = {421.83,-809.75,29.49}, done = false},
			[4] = {pos = {-1456.23,-234.61,49.8}, done = false},
			[5] = {pos = {-3169.31,1052.05,20.86}, done = false},
			[6] = {pos = {-1096.36,2710.0,19.11}, done = false},
			[7] = {pos = {616.91,2754.84,42.09}, done = false},
			[8] = {pos = {126.58,-215.31,54.56}, done = false},
		},
	},
	[2] = {
		name = "Liquor",
		prop = "prop_crate_11e",
		deliveries = {
			[1] = {pos = {-56.64,-1750.96,29.42}, done = false},
			[2] = {pos = {33.64,-1346.68,29.5}, done = false},
			[3] = {pos = {-1487.03,-383.3,40.16}, done = false},
			[4] = {pos = {1137.89,-978.62,46.42}, done = false},
			[5] = {pos = {-1227.16,-906.51,12.33}, done = false},
			[6] = {pos = {381.54,324.29,103.57}, done = false},
			[7] = {pos = {1169.23,2706.28,38.16}, done = false},
			[8] = {pos = {539.92,2670.01,42.16}, done = false},
		},
	},
}

Config.HighValueJobs = {
	[1] = {
		name = "Liquor",
		trailer = "tfrue46",
		prop = "prop_boxpile_06a",
		route = {
			[1] = {pos = {-306.35,-2714.35,6.0,314.45}, pallet = {pickup = {-313.6,-2717.76,6.0,226.09}, drop_off = {-306.9,-2728.23,6.0}}, done = false},
			[2] = {pos = {-201.63,-2390.17,6.0,269.95}, pallet = {pickup = {-203.16,-2394.94,6.0,89.49}, drop_off = {-211.23,-2385.75,6.0}}, done = false},
			[3] = {pos = {-536.15,-2841.45,6.0,19.78}, pallet = {pickup = {-527.42,-2840.9,6.0,119.35}, drop_off = {-536.44,-2849.78,6.01}}, done = false},
			[4] = {pos = {58.26,-2529.96,6.01,328.5}, pallet = {pickup = {60.87,-2534.63,6.0,61.36}, drop_off = {49.01,-2531.46,6.01}}, done = false},
			[5] = {pos = {-161.28,-2659.04,6.0,271.15}, pallet = {pickup = {-164.27,-2664.0,6.0,359.45}, drop_off = {-168.86,-2654.88,6.0}}, done = false},
		},
	},
	[2] = {
		name = "Groceries",
		trailer = "tfrue46",
		prop = "prop_boxpile_06a",
		route = {
			[1] = {pos = {-306.35,-2714.35,6.0,314.45}, pallet = {pickup = {-313.6,-2717.76,6.0,226.09}, drop_off = {-306.9,-2728.23,6.0}}, done = false},
			[2] = {pos = {-201.63,-2390.17,6.0,269.95}, pallet = {pickup = {-203.16,-2394.94,6.0,89.49}, drop_off = {-211.23,-2385.75,6.0}}, done = false},
			[3] = {pos = {-536.15,-2841.45,6.0,19.78}, pallet = {pickup = {-527.42,-2840.9,6.0,119.35}, drop_off = {-536.44,-2849.78,6.01}}, done = false},
			[4] = {pos = {58.26,-2529.96,6.01,328.5}, pallet = {pickup = {60.87,-2534.63,6.0,61.36}, drop_off = {49.01,-2531.46,6.01}}, done = false},
			[5] = {pos = {-161.28,-2659.04,6.0,271.15}, pallet = {pickup = {-164.27,-2664.0,6.0,359.45}, drop_off = {-168.86,-2654.88,6.0}}, done = false},
		},
	},
}
