~sc2Textures = Dictionary();

~sc2Textures.add(\melody -> Synth.newPaused(\onsetDetector));

~sc2Textures.add(\percussive ->
	Pbind(
		\type, \midi,
		\midicmd, \noteOn,
		\midiout, ~mc,
		\chan, 4,
		\midinote, 48,
		\delta, Pwrand(
			[Pexprand(0.1, 0.2), Rest(0.125), Rest(0.1)],
			[8, 2, 1].normalizeSum,
			inf
		),
		\decay, Pfunc({ ~mc.control(4, 80, 20.exprand(60)) }),
		\amp, 0.9
	).play.pause;
);

~sc2Textures.add(\drone ->
	Pbind(
		\type, \midi,
		\midicmd, \noteOn,
		\midiout, ~mc,
		\chan, Pseq([0, 1, 2], inf),
		\midinote, Prand([61, 62, 68], inf)
		+ Pwrand([-12, 0], [4, 8].normalizeSum, inf), // ori 60, 61, 67
		//\amp, Pgauss(0.5, 0.1),
		\dur, Pexprand(8, 10),
		\legato, Pwhite(1.25, 1.5),
		\amp, 0.9
	).play.pause;
);

~sc2Textures.add(\bass ->
	Pbind(
		\type, \midi,
		\midicmd, \noteOn,
		\midiout, ~mc,
		\chan, 3,
		\midinote, 61, // 60
		\dur, Pexprand(2, 4).round(0.25),
		\delta, Pexprand(8, 12).round(0.25),
		\amp, 0.9
		//\amp, Pgauss(0.8, 0.05)
	).play.pause;
);

~sc2Textures.add(\grainPerc ->
	Pbind(
		\instrument, \grainPerc,
		\buf, Prand(~sc2Samples, inf),
		\amp, Pbrown(0.7, 0.9),
		\bufrate, Pwhite(0.5, 1),
		\graindur, Pwhite(0.05, 0.2),
		\dur, Pexprand(0.5, 8),
		\delta, Pexprand(1, 4),
		\out, 0
	).play.pause;
);

~sc2Textures.add(\grainTexture ->
	Pbind(
		\instrument, \grainTexture,
		\buf, Prand(~sc2Samples, inf),
		\density, Pwhite(200, 300),
		\lenmin, 0.05,
		\lenmax, 0.2,
		\atk, Pexprand(2, 5),
		\sus, Pexprand(4, 8),
		\rel, Pexprand(3, 6),
		\amp, Pbrown(0.5, 0.9, 0.01),
		\delta, Pexprand(4, 8),
		\out, 0
	).play.pause;
);

~sc2Textures.add(\gong -> Pbind(
	\type, \midi,
	\midicmd, \noteOn,
	\midiout, ~ms,
	\note, 0,
	\chan, 0,
	\amp, 0.9,
	\delta, Pexprand(45, 90)
).play.pause);

~sc2Textures.add(\caOrch -> {
	~sc2CaOrch = Routine {
		var ca = Pca1(
			Array.fill(6, { 2.rand }),
			Prand([110, 90],inf)
		).asStream;

		loop {
			ca.next.do { |on, i|
				if (on.asBoolean) {
					switch(i)
					{ 0 }{ ~sc2Textures[\melody].set(\gate, 1).run(true) }
					{ 1 }{ ~sc2Textures[\percussive].play }
					{ 2 }{ ~sc2Textures[\grainPerc].play }
					{ 3 }{ ~sc2Textures[\drone].play }
					{ 4 }{ ~sc2Textures[\grainTexture].play }
					{ 5 }{ ~sc2Textures[\bass].play };
				}{
					switch(i)
					{ 0 }{ ~sc2Textures[\melody].set(\gate, 0).run(false) }
					{ 1 }{ ~sc2Textures[\percussive].pause }
					{ 2 }{ ~sc2Textures[\grainPerc].pause }
					{ 3 }{ ~sc2Textures[\drone].pause }
					{ 4 }{ ~sc2Textures[\grainTexture].pause }
					{ 5 }{ ~sc2Textures[\bass].pause };
				}
			};
			30.0.exprand(60.0).wait;
		};
	};
});

~sc2Textures[\caOrch].();

"Scene 2 textures are loaded".postln;