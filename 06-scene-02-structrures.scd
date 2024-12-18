~sc2DefStructures = {

	OSCdef(\onsetMelody, { |msg|
		var walk = Pbrown(0, 15, 15).asStream;
		// Scale calculation
		var scale = [
			Scale.pelog,
			Scale.hirajoshi,
			Scale.scriabin
		].wchoose([5, 10, 4].normalizeSum);

		var note = scale.degreeToFreq(
			walk.next,
			49.midicps,
			1
		).cpsmidi.round.asInteger;

		// decay time
		~mc.control(5, 80, 20.exprand(50));
		// delay send
		~mc.control(5, 12, 30.rrand(50));
		// note send
		~mc.noteOn(5, note, 0.5.gauss(0.05).linlin(0, 1, 0, 127));
	}, '/onset');


	MIDIdef.cc(\sc2Drone, { |val|
		if (val.asBoolean) {
			"Scene 2 drone on".postln;
			~mc.program(7, 1);
			//~ms.program(7, 0);
			~sc2Textures[\drone].play;
		}{
			"Scene 2 drone off".postln;
			~sc2Textures[\drone].pause;
		};
	}, 9, 2);


	MIDIdef.cc(\sc2CA, { |val|
		if (val.asBoolean) {
			~mc.program(7, 1);
			"Scene 2 CA on".postln;
			~sc2CaOrch.reset.play;
			//~sc2Textures.at(\melody).set(\gate, 1).run(true);
		}{
			"Scene 2 CA off".postln;
			~sc2CaOrch.stop;
			~sc2Textures[\melody].set(\gate, 0).run(false);
			[\percussive, \grainPerc, \drone, \grainTexture, \bass].do { | key |
				~sc2Textures[key].pause;
			};
		};
	}, 10, 2);


	MIDIdef.cc(\sc2Gong, { |val|
		if (val.asBoolean) {
			~ms.program(7, 3);
			"Scene 2 gong on".postln;
			~sc2Textures[\gong].play;
		}{
			"Scene 2 gong off".postln;
			~sc2Textures[\gong].pause;
		};
	}, 11, 2);


	"Scene 2 structures are loaded".postln;
};


ServerTree.add(~sc2DefStructures);