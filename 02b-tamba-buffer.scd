// Create a wavetable
~tambaCreateWaveTable = {
	var wt_sig;

	wt_sig = 10.collect { |i|
		var numSegs = i.linexp(0, 9, 4, 40).round;

		Env(
			[0] ++ ({ 1.0.rand }.dup(numSegs-1) * [1, -1]).scramble ++ [0],
			{ exprand(1, i.linexp(0, 9, 1, 50)) }.dup(numSegs),
			{ [\sine, 0, exprand(1, 20) * [1, -1].choose].wchoose([9-1, 3, i].normalizeSum) }.dup(numSegs)
		).asSignal(1024);

	};

	~tamba_wt_buf = Buffer.allocConsecutive(10, s, 2048, 1, { |buf, index|
		buf.setnMsg(0, wt_sig[index].asWavetable);
	});
};


~tambaCreateRebabTable = {
	var wt;
	wt = Array.fill(4, {
		var numSegs = rrand(4, 20);
		Env(
			levels: [0] ++
			(({ rrand(0, 1) })!(numSegs-1) * [1, -1]).scramble
			++ [0],
			times: { exprand(1, 20) }!numSegs,
			curve: { rrand(-20,20) }!numSegs
		).asSignal(1024).asWavetable;
	});
	~tambaRebabBuf = Buffer.allocConsecutive(4, s, 2048);
	~tambaRebabBuf.do({
		arg buf, i;
		buf.loadCollection(wt[i]);
	});
};


// Create laras
~tambaLoadLaras = {
	var path = [
		"/Users/bilawa/Library/CloudStorage/Dropbox/2 - Project/Gig 241220/Liveset 241220/assets/rbipelogbem.scl",
		"/Users/bilawa/Library/CloudStorage/Dropbox/2 - Project/Gig 241220/Liveset 241220/assets/rbipelogbemsorog.scl"
	];

	~tambaLaras = Dictionary();

	path.do { |pth, i|
		var name = [
			\pelogBem,
			\pelogBemSorog,
		];

		var scl = Scala.open(pth);

		~tambaLaras.add(name[i] -> scl.scale);
	};
};


// Gamelan samples as dictionary
~tambaLoadGamelanSamplesDict = {
	var samplePath = PathName("/Users/bilawa/Library/CloudStorage/Dropbox/7 - Sound Samples/Latent Sonorities");

	var saronpelog = (samplePath +/+ PathName("SaronPelog")).files.collect { |file|
		if (file.extension == "wav"){
			Buffer.readChannel(s, file.fullPath, channels:[0]);
		};
	};

	var bonangslendro = (samplePath +/+ PathName("BonangBarungSlendro")).files.collect { |file|
		if (file.extension == "wav"){
			Buffer.readChannel(s, file.fullPath, channels:[0]);
		};
	};

	~tambaGamelanDict = Dictionary.newFrom([
		\SaronPelog, saronpelog,
		\BonangBarungSlendro, bonangslendro
	]);

	/*
	samplePath.folders.do { | folder |
		var sampleSym = folder.folderName.asSymbol;

		var bufArray =	folder.files.collect { | file|
			if (file.extension == "wav"){
				Buffer.readChannel(s, file.fullPath, channels:[0]);
			};
		};

		~tambaGamelanDict.add(sampleSym -> bufArray);
	};
	*/
};


~tambaCreateWaveTable.();
~tambaCreateRebabTable.();
~tambaLoadLaras.();
~tambaLoadGamelanSamplesDict.();

"Tamba buffer is loaded".postln;