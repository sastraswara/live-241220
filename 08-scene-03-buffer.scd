~sc3MakeWT = {
	var wt = 6.collect {
		var numSeg = 7; //Ppoisson(6, inf).asStream.next;
		var segments = Env(
			levels: [0] ++ Array.rand(numSeg-1, -1.0, 1.0).normalize(-1.0, 1.0) ++ [0],
			times: Array.exprand(numSeg, 0.1, 1.0),
			curve: Array.fill(numSeg, { [\lin, \sine].choose })
		);
		segments.asSignal(8192);
	};

	~wtBuf = wt.collect { |table|
		Buffer.loadCollection(s, table.asWavetable);
	};
};


~sc3MakeLaras = {
	var pelog = Tuning(
		(#[0, 122, 273, 538, 673, 775, 951]/100),
		name: "Pelog"
	);

	var slendroTune = Tuning(
		(#[0, 236, 464, 710, 958]/100),
		name: "Slendro"
	);

	~laras = Dictionary();

	~laras.add(\bem -> Scale(
		#[0, 1, 2, 4, 5],
		7,
		tuning: pelog,
		name: "Pelog Bem"
	));

	~laras.add(\barang -> Scale(
		#[1, 2, 4, 5, 6],
		7,
		tuning: pelog,
		name: "Pelog Barang"
	));

	~laras.add(\slendro -> Scale(
		#[0, 1, 2, 3, 4],
		5,
		tuning: ~slendroTune,
		name: "Slendro Scale"
	));
};


~sc3dbs = [
	"/Users/bilawa/Library/CloudStorage/Dropbox/7 - Sound Samples/music/501199__prodastri__astri-sound-bit-011-piano-satie-ish-and-yo.wav",
	"/Users/bilawa/Library/CloudStorage/Dropbox/7 - Sound Samples/music/debussy-fast.wav",
	"/Users/bilawa/Library/CloudStorage/Dropbox/7 - Sound Samples/music/debussy-slow.wav"
].collect { |pth| Buffer.readChannel(s, pth, channels:[0]) };


~sc3LoadBalungan = {
	var saron = [
		"/Users/bilawa/Library/CloudStorage/Dropbox/7 - Sound Samples/Gamelan Komplet/Saron/SBPL1.wav",
		"/Users/bilawa/Library/CloudStorage/Dropbox/7 - Sound Samples/Gamelan Komplet/Saron/SBPL2.wav",
		"/Users/bilawa/Library/CloudStorage/Dropbox/7 - Sound Samples/Gamelan Komplet/Saron/SBPL3.wav",
		"/Users/bilawa/Library/CloudStorage/Dropbox/7 - Sound Samples/Gamelan Komplet/Saron/SBPL4.wav",
		"/Users/bilawa/Library/CloudStorage/Dropbox/7 - Sound Samples/Gamelan Komplet/Saron/SBPL5.wav",
		"/Users/bilawa/Library/CloudStorage/Dropbox/7 - Sound Samples/Gamelan Komplet/Saron/SBPL6.wav",
		"/Users/bilawa/Library/CloudStorage/Dropbox/7 - Sound Samples/Gamelan Komplet/Saron/SBPL7.wav"
	].collect { |pth| Buffer.readChannel(s, pth, channels:[0]) };

	var demung = [
		"/Users/bilawa/Library/CloudStorage/Dropbox/7 - Sound Samples/Gamelan Komplet/Demung/SDPL1.wav",
		"/Users/bilawa/Library/CloudStorage/Dropbox/7 - Sound Samples/Gamelan Komplet/Demung/SDPL2.wav",
		"/Users/bilawa/Library/CloudStorage/Dropbox/7 - Sound Samples/Gamelan Komplet/Demung/SDPL3.wav",
		"/Users/bilawa/Library/CloudStorage/Dropbox/7 - Sound Samples/Gamelan Komplet/Demung/SDPL4.wav",
		"/Users/bilawa/Library/CloudStorage/Dropbox/7 - Sound Samples/Gamelan Komplet/Demung/SDPL5.wav",
		"/Users/bilawa/Library/CloudStorage/Dropbox/7 - Sound Samples/Gamelan Komplet/Demung/SDPL6.wav",
		"/Users/bilawa/Library/CloudStorage/Dropbox/7 - Sound Samples/Gamelan Komplet/Demung/SDPL7.wav"
	].collect { |pth| Buffer.readChannel(s, pth, channels:[0]) };

	var peking = [
		"/Users/bilawa/Library/CloudStorage/Dropbox/7 - Sound Samples/Gamelan Komplet/Peking/SPPL1.wav",
		"/Users/bilawa/Library/CloudStorage/Dropbox/7 - Sound Samples/Gamelan Komplet/Peking/SPPL2.wav",
		"/Users/bilawa/Library/CloudStorage/Dropbox/7 - Sound Samples/Gamelan Komplet/Peking/SPPL3.wav",
		"/Users/bilawa/Library/CloudStorage/Dropbox/7 - Sound Samples/Gamelan Komplet/Peking/SPPL4.wav",
		"/Users/bilawa/Library/CloudStorage/Dropbox/7 - Sound Samples/Gamelan Komplet/Peking/SPPL5.wav",
		"/Users/bilawa/Library/CloudStorage/Dropbox/7 - Sound Samples/Gamelan Komplet/Peking/SPPL6.wav",
		"/Users/bilawa/Library/CloudStorage/Dropbox/7 - Sound Samples/Gamelan Komplet/Peking/SPPL7.wav"
	].collect { |pth| Buffer.readChannel(s, pth, channels:[0]) };

	~sc3kpl = [
		"/Users/bilawa/Library/CloudStorage/Dropbox/7 - Sound Samples/Gamelan Komplet/Gong/Gong Kempul/GKPL1p.wav",
		"/Users/bilawa/Library/CloudStorage/Dropbox/7 - Sound Samples/Gamelan Komplet/Gong/Gong Kempul/GKPL2p.wav",
		"/Users/bilawa/Library/CloudStorage/Dropbox/7 - Sound Samples/Gamelan Komplet/Gong/Gong Kempul/GKPL3p.wav",
		"/Users/bilawa/Library/CloudStorage/Dropbox/7 - Sound Samples/Gamelan Komplet/Gong/Gong Kempul/GKPL5p.wav",
		"/Users/bilawa/Library/CloudStorage/Dropbox/7 - Sound Samples/Gamelan Komplet/Gong/Gong Kempul/GKPL6p.wav"
	].collect { |pth| Buffer.readChannel(s, pth, channels:[0]) };

	~sc3blg = demung ++ saron ++ peking;
};

~sc3MakeWT.();
~sc3MakeLaras.();
~sc3LoadBalungan.();

"Scene 3 buffers are loaded".postln;