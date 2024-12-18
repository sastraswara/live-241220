//var amp = 0.4;
// set delay time 24
ServerTree.add({ ~sc5t = TempoClock(90/60) });

~sc5Textures = Dictionary();

~sc5Textures.add(\ktk -> Pbind(
	\instrument, \sc5play,
	\buf, ~sc5samples[\kk][1],
	\amp, 0.3 * 4,
	\pan, -0.4,
	\delta, 0.25,
	\out, 0
).play(~sc5t, quant:1).pause);

~sc5Textures.add(\kng -> Pbind(
	\instrument, \sc5play,
	\buf, Prand(~sc5samples[\kenong], inf),
	\amp, 0.3 * 6,
	\sus, 8,
	\pan, 0.4,
	\delta, Pexprand(4, 6),
	\out, 0
).play(~sc5t, quant:1).pause);

~sc5Textures.add(\gg -> Pbind(
	\instrument, \sc5play,
	\buf, ~sc5samples[\gong],
	\amp, 4.dbamp, //0.3 * 9,
	\sus, 30,
	\delta, Pexprand(40, 60),
	\out, 0
).play(~sc5t, quant:1).pause);

~sc5Textures.add(\kick -> Pbind(
	\type, \midi,
	\midicmd, \noteOn,
	\midiout, ~mc, // ~ms,
	\chan, 4,
	\midinote, 50, //0,
	\dur,Pwrand([0.125, 0.25, Rest(0.125)], [4, 8, 2].normalizeSum, inf),
	\amp, 0.9
	//\dur, Pwrand([0.125, 0.25, 0.5], [4, 8, 6].normalizeSum, inf)
).play(quant:1).pause);


~sc5Textures.add(\bass -> Pbind(
	\type, \midi,
	\chan, 0,
	\midicmd, \noteOn,
	\midinote, Prand([50, 42, 47], inf), //38,
	\midiout, ~mc,
	\dur, Pexprand(8, 16),
	\amp, 0.9
).play(quant: 1).pause);


~sc5Textures.add(\kendhangAmbient -> Pbind(
	\type, \midi,
	\midicmd, \noteOn,
	\midiout, ~ms,
	\chan, 0,
	\midinote, Prand([1, 2, 3], inf),
	\dur, Pexprand(0.125, 2),
	\del, Pfunc({ |ev|
		~ms.control(ev[\midinote], 12, 30.rrand(127)); // del send
		~ms.control(ev[\midinote], 80, 30.rrand(127)); // dec time
	}),
	\amp, 0.9
).play(quant: 1).pause);


~sc5Textures.add(\crunch -> Pbind(
	\type, \midi,
	\midicmd, \noteOn,
	\midiout, ~ms,
	\chan, 0,
	\midinote, 4,
	\dur, Pexprand(0.125, 0.5),
	\dec, Pbrown(5, 12),
	\param, Pfunc({ |ev|
		~ms.control(4, 13, 10.rrand(90)); // rev send
		~ms.control(4, 71, 80.rrand(127)); // resonance
		~ms.control(4, 80, ev.at(\dec)); // dec
	}),
	\amp, 0.9
).play(quant:1).pause);


~sc5Textures.add(\click -> Pbind(
	\type, \midi,
	\midicmd, \noteOn,
	\midiout, ~ms,
	\chan, 0,
	\midinote, 5,
	\dur, Pexprand(0.125, 0.5),
	\dec, Pbrown(5, 12),
	\param, Pfunc({ |ev|
		~ms.control(5, 13, 10.rrand(90)); // rev send
		~ms.control(5, 71, 80.rrand(127)); // resonance
		~ms.control(5, 80, ev.at(\dec)); // dec
	}),
	\amp, 0.9
).play(quant: 1).pause);


~sc5Textures.add(\grainAmbient -> Pbind(
	\instrument, \sc5grainTexture,
	\buf, Prand(~sc5samples.at(\soundscape), inf),
	\bufrate, Pwhite(0.05, 0.5),
	\sus, Pwhite(4, 16),
	\rel, Pwhite(2, 8),
	\atk, Pwhite(1, 4),
	//\pos, Pwhite(0, 0.9),
	\delta, Pexprand(8, 16),
	\amp, Pwrand([1, 0], [0.8, 0.2], inf) * -20.dbamp
).play.pause);


~sc5Textures.add(\soundscape -> {
	~sc5soundscape = Routine {
		var keys = [\kendhangAmbient, \crunch, \click, \grainAmbient];
		loop {
			var soundArr = Array.fill(keys.size, { [0, 1].wchoose([0.2, 0.8]) });

			soundArr.do { |on, i|
				if (on.asBoolean) {
					~sc5Textures.at(keys.at(i)).play;
				}{
					~sc5Textures.at(keys.at(i)).pause;
				}
			};
			20.0.exprand(40.0).wait;
		};
	};
});

"Scene 5 Textures are loaded".postln;