~sc5DefStructures = {

	MIDIdef.cc(\sc5SoundScapes, { |val|
		if (val.asBoolean) {
			~ms.program(7, 6);
			~mc.program(7, 4);
			~sc5Textures.at(\soundscape).reset.play;
			"Scene 5 soundscape on".postln;
		}{
			~sc5Textures.at(\soundscape).stop;
			[\kendhangAmbient, \crunch, \click, \grainAmbient].do { |key| ~sc5Textures.at(key).pause };
			"Scene 5 soundscape off".postln;
		};
	}, 25, 2);


	MIDIdef.cc(\sc5Bass, { |val|
		if (val.asBoolean) {
			"Scene 5 bass on".postln;
			~mc.program(7, 4);
			~mc.control(1, 67, 127); // gates on
			~mc.control(2, 67, 127);
			~sc5Textures.at(\bass).play(quant: [1, 10]);
		}{
			"Scene 5 bass off".postln;
			~sc5Textures.at(\bass).pause;
		};
	}, 26, 2);

	MIDIdef€.cc(\sc5Kick, { |val|
		if (val.asBoolean) {
			"Scene 5 kick on".postln;
			~mc.program(7, 4);
			~sc5Textures.at(\kick).play(quant: 1);
		}{
			"Scene 5 kick off".postln;
			~sc5Textures.at(\kick).pause;
		};
	}, 27, 2);

	MIDIdef.cc(\sc5gongan, { |val|
		if (val.asBoolean) {
			"Scene 5 gongan on".postln;
			[\ktk, \kng, \gg].do { |sym| ~sc5Textures.at(sym).play(~sc5t, quant: 1) };
		}{
			"Scene 5 gongan off".postln;
			[\ktk, \kng, \gg].do { |sym| ~sc5Textures.at(sym).pause };
		};
	}, 28, 2);

	MIDIdef.cc(\sc5GongOneShot, {
		Synth(\sc5play, [
			\buf, ~sc5samples[\gong],
			\amp, 4.dbamp, //0.3 * 9,
			\sus, 30,
			\out, 0
		]);
	}, 32, 2);

	"Scene 5 structures are loaded".postln;
};


ServerTree.add(~sc5DefStructures);