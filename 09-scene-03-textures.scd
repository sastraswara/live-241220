~sc3Textures = Dictionary();

~sc3Textures.add(\singleMelody -> Pbind(
	\instrument, \sc3osc,
	\buf, Prand(~wtBuf, inf),
	\deg, Pbrown(0, 15, 3),
	\freq, Pfuncn({ |ev|
		var laras = [~laras[\bem], Scale.lydian].wchoose([40, 5].normalizeSum);

		laras.degreeToFreq(
			ev[\deg],
			148.5,
			1
		);
	}, inf),
	\atk, Pexprand(3, 5),
	\dur, Pexprand(4, 8),
	\rel, Pexprand(4, 6),
	\delta, Pkey(\dur),
	\amp, 0.2 / (Pkey(\deg) + 1),
	\pan, Pwhite(-1.0, 1.0),
	\out, 0
).play.pause);


~sc3Textures.add(\bigCluster -> Pbind(
	\instrument, \sc3osc,
	\buf, Prand(~wtBuf, inf),
	\deg, Pbrown(0, 15, 10),
	\freq, Pfuncn({ |ev|
		var laras = [
			~laras[\bem],
			~laras[\slendro],
			Scale.lydian,
			Scale.scriabin
		].wchoose([40, 5, 10, 1].normalizeSum);

		laras.degreeToFreq(
			ev[\deg],
			148.5,
			1
		);
	}, inf),
	\atk, Pexprand(3, 5),
	\dur, Pexprand(4, 8),
	\rel, Pexprand(4, 6),
	\delta, Pkey(\dur) * Pwhite(1/64, 1/4),
	\amp, (0.8 * 0.2) / (Pkey(\deg) + 1),
	\pan, Pwhite(-1.0, 1.0), //0,
	\out, 0
).play.pause);


~sc3Textures.add(\bass -> Pbind(
	\type, \midi,
	\midicmd, \noteOn,
	\midiout, ~mc,
	\chan, 0,
	\midinote, Pseq([50, 51], inf),
	\amp, 0.9,
	\dur, Pexprand(8, 16)
).play.pause);


~sc3Textures.add(\brassage -> Pbind(
	\type, \midi,
	\midicmd, \noteOn,
	\midiout, ~ms,
	\chan, Pwhite(0, 5),
	\params, Pfunc({ |ev|
		~ms.control(ev.at(\chan), 80, 10.rrand(40));
		~ms.control(ev.at(\chan), 19, 0.rrand(33));
		~ms.control(ev.at(\chan), 20, 3.rrand(15));
		~ms.control(ev.at(\chan), 74, 60.rrand(100));
		~ms.control(ev.at(\chan), 71, 127.rand);
		~ms.control(ev.at(\chan), 18, [0, 127].choose);
		~ms.control(ev.at(\chan), 10, 0.rrand(127));
		~ms.control(ev.at(\chan), 12, 30.rrand(127));
	}),
	\dur, Pwrand([0.125, Rest(0.125)], [10, 8].normalizeSum, inf),
	\amp, 0.9
).play.pause);


~sc3Textures.add(\cluster -> Synth.newPaused(\sc3clusterOnset, [
	\buf, ~sc3dbs.at(0)
]));


~sc3Textures.add(\walk -> Synth.newPaused(\sc3walkOnset, [
	\buf, ~sc3dbs.at(1)
]));


~sc3Textures.add(\kempul -> Pbind(
	\instrument, \sc3sampplay,
	\buf, Prand(~sc3kpl, inf),
	\amp, 0.9,
	\sus, Pexprand(8, 12),
	\delta, Pexprand(20, 40)
).play.pause);


"Scene 3 textures are loaded".postln;