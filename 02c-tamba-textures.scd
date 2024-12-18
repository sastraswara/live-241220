// Music functions
~tambaFunc = Dictionary();

~tambaTextures = Dictionary();

~tambaTextures.add(\rebabWalk -> Pbind(
	\instrument, \tambaVosc,
	\dur, Pexprand(4, 16),
	\atk, Pexprand(2, 6),
	\sus, 0,
	\rel, Pexprand(8, 16),
	\c0, Pexprand(1, 2),
	\c1, Pexprand(1, 2).neg,
	\detune, Pfunc({ rrand(0.15, 0.4) } ),
	\interfreq, 10.reciprocal,
	\buf, ~tamba_wt_buf[0],
	\deg, Pbrown(12, 17, 1),
	\freq, Pfunc({ |ev|
		//var deg = walkPattern.next.asInteger;
		var key;

		if (0.6.coin) {
			key = \pelogBem;
		} {
			key = \pelogBemSorog;
		};

		~tambaLaras[key].degreeToFreq(ev[\deg], 148.5, 0)
	}),
	\amp, Pexprand(0.2, 0.4),
	\pan, Pwhite(-1.0, 1.0),
	\out, 0, // 2
	//\rsend, -5
).play(quant: 1).pause;
);

// Rebab Cluster
~tambaTextures.add(\rebabCluster -> Pbind(
	\instrument, \tambaVosc,
	\dur, Pwrand([1, 4, 6, 9, 12], [0.35, 0.25, 0.2, 0.15, 0.05], inf),
	\atk, Pexprand(3, 6),
	\sus, 0,
	\rel, Pexprand(5, 10),
	\c0, Pexprand(1, 2),
	\c1, Pexprand(1, 2).neg,
	\detune, Pfunc({ rrand(0.15, 0.4) }!3 ),
	\interfreq, 10.reciprocal,
	\buf, ~tamba_wt_buf[0],
	\freq, Pfunc({
		var key = \pelogBem;
		var degArr;
		if (0.4.coin){
			key = \pelogBemSorog;
		};
		degArr = (-10..20).collect { |deg|
			~tambaLaras[\pelogBem].degreeToFreq(deg, 148.5*2, 0);
		};
		degArr.scramble[0..rrand(2, 10)];
	}),
	\amp, Pexprand(0.05, 0.2)*1.25,//Pexprand(0.001, 0.01)* 2,
	\pan, Pwhite(-1.0, 1.0),
	\out, 0, // 2
).play(quant: 1).pause;
);

// Rebab with Gong Partials
~tambaTextures.add(\rebabPartials -> Pbind(
	\instrument, \tambaVosc,
	\dur, Pwrand([1, 4, 6, 9, 12], [0.35, 0.25, 0.2, 0.15, 0.05], inf),
	\atk, Pexprand(3, 6),
	\sus, 0,
	\rel, Pexprand(5, 10),
	\c0, Pexprand(1, 2),
	\c1, Pexprand(1, 2).neg,
	\detune, Pfunc({ rrand(0.15, 0.4) }!3 ),
	\interfreq, 10.reciprocal,
	\buf, ~tamba_wt_buf[0],
	//\scale, ~laras[\pelogBem], //Scale.minorPentatonic,
	\freq, Pfunc({
		// Output Fluidbuf Sinefeatures
		var gongParts = [
			50.124778747559, 319.98275756836, 473.56112670898,
			656.83489990234, 864.19073486328, 1050.1136474609,
			1237.0729980469, 1428.0616455078, 1567.7589111328,
			1677.8873291016, 1781.8243408203, 1941.7581787109,
			2144.1215820312, 2282.5983886719, 2465.06640625
		];
		gongParts.scramble[0..rrand(1, 10)];
	}),
	\amp, Pexprand(0.05, 0.2),//Pexprand(0.001, 0.01)* 2,
	\pan, 0,//Pwhite(-1.0, 1.0),
	\out, 0, // 2
	//\rout, ~rbus,
	//\rsend, -5
).play(quant: 1).pause;
);

// Rebab Senggrengan 1-5
~tambaTextures.add(\rebabSenggrengan -> Pbind(
	\instrument, \tambaVosc,
	\buf, ~tamba_wt_buf[0],
	\dur, 1,
	\freq, [148.5, 221.9], // 1-5
	\detune, Pwhite(0.03, 0.2),
	\atk, Pexprand(1, 4),
	\sus, Pexprand(0.1, 1),
	\rel, Pexprand(0.5, 2),
	\amp, Pgauss(0.1, 0.025),
	\out, 0 // 2
).play(quant: 1).pause;
);

// Rebab Drone
~tambaTextures.add(\rebabDrone -> Pbind(
	\instrument, \tambaVosc,
	\buf, ~tamba_wt_buf[0],
	\dur, 1,
	\freq, 55.48,
	\detune, Pwhite(0.03, 0.2),
	\atk, 2,
	\sus, 0.1,
	\rel, 2,
	\amp, 0.15,
	\out, 0 // 2
).play(quant: 1).pause;
);


// Percussion playing
//+++
~tambaTextures.add(\stochasticRun ->
	Routine {
		loop{
			var clusterSize = 5.rrand(15);
			var coin = 1.0.rand;
			var bufArray = ~tambaGamelanDict[\SaronPelog] ++ ~tambaGamelanDict[\BonangBarungSlendro];

			clusterSize.do {
				Synth(\tambaPercussionPlayer, [
					\buf, bufArray.choose,
					\amp, 0.2.rrand(0.7),
					\rel, 2.exprand(4),
					\rate, [0.25, 0.5, 1, 2, 4].choose * (-0.1.rrand(0.1)).midiratio, // -1, 1
					\out, 0
				]);
			};

			if (coin < 0.95) {
				(0.1).wait;
			} {
				4.0.exprand(8.0).wait;
			};
		}
	};
);


~tambaFunc.add(\bounce -> {
	var bufArr = ~tambaGamelanDict[\SaronPelog] ++ ~tambaGamelanDict[\BonangBarungSlendro];

	var walkPattern = Pwalk(
		bufArr,
		Prand((-6..6), inf),
		1,
		bufArr.size.rand
	);

	var randPattern = Prand(bufArr, inf);

	var bufPattern = [walkPattern, randPattern];

	Pbind(
		\instrument, \tambaPercussionPlayer,
		\buf, bufPattern.choose,
		\dur, Pgeom(1.rrand(2), 0.8, 10.rrand(20)),
		\rate, [0.125, 0.25, 0.5, 1, 2].choose * Pwhite(0.98, 1.02),
		\rel, 0.25.rrand(0.5),
		\pan, Pwhite(-1.0, 1.0),
		\amp, Pgauss(0.8, 0.1),
		\out, 0//2
	).play;
});


~tambaTextures.add(\stochasticBounce -> Routine {
	loop {
		~tambaFunc.at(\bounce).value;
		0.75.exprand(4.0).wait;
	};
});


~tambaTextures.add(\layers -> {
	var samp = ~tambaGamelanDict[\SaronPelog];
	var variation = [
		[samp[23]],
		[samp[23], samp[28]],
		[samp[13], samp[23], samp[28]],
		[samp[23], samp[28], samp[23]],
		[samp[23], samp[28], samp[23], samp[8]],
		[samp[28], samp[23], samp[13], samp[8]],
		[samp[13], samp[8]],
		[samp[13], samp[8], samp[3]]
	];
	var durArr = [4/3, 3/4, 5/4, 4/5, 5/7, 9/7, 7/6, 6/7, 8/7, 7/8, 9/8]*0.25; //0.25
	var durSeq = Pxrand(durArr, inf).asStream;

	var layer = { |pan|
		var seq = Pseq(variation, inf).asStream; // Pseq
		var poisson = Pexprand(20, 60).asStream;
		var amp = Pgauss(0.5, 0.1).asStream;
		var dev = Pwhite(0.95, 1.05).asStream;

		Routine {
			loop {
				var eventDur = poisson.next;
				var pat = seq.next;
				var acum = 0;
				var dur = durSeq.next;

				while({ acum < eventDur }, {
					pat.do { |note|
						Synth(\tambaPercussionPlayer, [
							\buf, note, \rate, 0.25.gauss(0.02),
							\rel, 0.7, \amp, amp.next * [0, 1].wchoose([0.2, 0.8]), \pan, pan, \out, 0
						]);
						acum = acum + dur;
						dur.wait;
					};
				});
			};
		};//.play(quant: 1);
	};

	~tambaTextureLayers = [-1, -0.5, 0, 0.5, 1].collect { |pval| layer.value(pval) };
});


~tambaTextures.at(\layers).value;

"Tamba textures are loaded".postln;