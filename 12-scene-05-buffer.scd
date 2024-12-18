~loadSampleSc5 = {
	var prefix = "/home/respati/"; // "/Users/bilawa/Library/CloudStorage/"

	var kenong = [
		"/Users/bilawa/Library/CloudStorage/Dropbox/7 - Sound Samples/Gamelan Komplet/Kenong/KPL1h.wav",
		"/Users/bilawa/Library/CloudStorage/Dropbox/7 - Sound Samples/Gamelan Komplet/Kenong/KPL1hs.wav",
		"/Users/bilawa/Library/CloudStorage/Dropbox/7 - Sound Samples/Gamelan Komplet/Kenong/KPL2.wav",
		"/Users/bilawa/Library/CloudStorage/Dropbox/7 - Sound Samples/Gamelan Komplet/Kenong/KPL2s.wav",
		"/Users/bilawa/Library/CloudStorage/Dropbox/7 - Sound Samples/Gamelan Komplet/Kenong/KPL3.wav",
		"/Users/bilawa/Library/CloudStorage/Dropbox/7 - Sound Samples/Gamelan Komplet/Kenong/KPL3s.wav",
		"/Users/bilawa/Library/CloudStorage/Dropbox/7 - Sound Samples/Gamelan Komplet/Kenong/KPL5.wav",
		"/Users/bilawa/Library/CloudStorage/Dropbox/7 - Sound Samples/Gamelan Komplet/Kenong/KPL5s.wav",
		"/Users/bilawa/Library/CloudStorage/Dropbox/7 - Sound Samples/Gamelan Komplet/Kenong/KPL6.wav",
		"/Users/bilawa/Library/CloudStorage/Dropbox/7 - Sound Samples/Gamelan Komplet/Kenong/KPL6s.wav"
	].collect { |pth| Buffer.read(s, pth) };

	var gong = Buffer.read(s, "/Users/bilawa/Library/CloudStorage/Dropbox/7 - Sound Samples/Gamelan Komplet/Gong/Gong Ageng/GAp.wav");

	var ketukkempyang = [
		"/Users/bilawa/Library/CloudStorage/Dropbox/7 - Sound Samples/Gamelan Komplet/Ketuk/KtPL6.wav",
		"/Users/bilawa/Library/CloudStorage/Dropbox/7 - Sound Samples/Gamelan Komplet/Kempyang/KpPL6.wav"
	].collect { |pth| Buffer.read(s, pth) };

	var soundscape = [
		"/Users/bilawa/Library/CloudStorage/Dropbox/7 - Sound Samples/children/PlaygroundChildren_BWU.13.wav",
		"/Users/bilawa/Library/CloudStorage/Dropbox/7 - Sound Samples/children/PlaygroundChildren_SFXB.136.wav",
		"/Users/bilawa/Library/CloudStorage/Dropbox/7 - Sound Samples/ritual/149093__lepolainyann__tibetan-buddhist-chant.wav",
		"/Users/bilawa/Library/CloudStorage/Dropbox/7 - Sound Samples/ritual/274835__alex_hears_things__thai_buddhist_monk_chant.wav"
	].collect { |pth| Buffer.readChannel(s, pth, channels: [0])};

	~sc5samples = Dictionary.newFrom([
		\kenong, kenong,
		\kk, ketukkempyang,
		\gong, gong,
		\soundscape, soundscape
	]);
};


~loadSampleSc5.();

"Scene 5 buffers are loaded".postln;