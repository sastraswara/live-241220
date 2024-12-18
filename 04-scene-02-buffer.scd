~sc2Samples = [
	"/Users/bilawa/Library/CloudStorage/Dropbox/7 - Sound Samples/children/PlaygroundChildren_BWU.13.wav",
	"/Users/bilawa/Library/CloudStorage/Dropbox/7 - Sound Samples/children/PlaygroundChildren_SFXB.136.wav",
	"/Users/bilawa/Library/CloudStorage/Dropbox/7 - Sound Samples/children/PlaygroundIndoor_S08AM.50.wav",
	"/Users/bilawa/Library/CloudStorage/Dropbox/7 - Sound Samples/bike/Bike_Pedals.wav",
	"/Users/bilawa/Library/CloudStorage/Dropbox/7 - Sound Samples/bike/BRS_Bicycle_Retro_Cruiser_OB_Ride_Fast_1.wav",
	"/Users/bilawa/Library/CloudStorage/Dropbox/7 - Sound Samples/bike/SO_SN_foley_bicycle_passby_ravine.wav",
	"/Users/bilawa/Library/CloudStorage/Dropbox/7 - Sound Samples/metal/ESM_Heavy_Cart_Push_3_Heavy_Rickety_Rattle_Wood_Wheel_Wagon.wav",
	"/Users/bilawa/Library/CloudStorage/Dropbox/7 - Sound Samples/metal/ESM_Heavy_Object_Slide_or_Push_5_Heavy_Metallic_Grinding_Screech_Deep_Junk.wav",
	"/Users/bilawa/Library/CloudStorage/Dropbox/7 - Sound Samples/metal/Rust1_metal_racks_bassy_rattle_heavy_05_2.wav"
].collect { |pth|
	Buffer.readChannel(s, pth, channels: [0]);
};

"Scene 2 buffers are loaded".postln;