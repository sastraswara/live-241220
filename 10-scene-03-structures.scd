~sc3DefStructures = {

	~sc3PCA = Pclutch(
		Pca1(Array.fill(6, { 2.rand }), 110),
		Pwrand([0, 1], [0.2, 0.8], inf)
	).asStream;

	OSCdef(\sc3Cluster, { |msg|
		var cluster = ~sc3PCA.next;

		var scale = [
			Scale.pelog,
			Scale.lydian,
			Scale.prometheus
		].wchoose([6, 6, 4].normalizeSum);

		//var oct = [1, 2].wchoose([6, 8].normalizeSum);
		var root = 49;

		cluster.do { |val, idx|
			if (val == 1) {
				var oct = [-1, 0, 1, 2].wchoose([2, 4, 6, 8].normalizeSum);
				~mc.noteOn(idx, scale.degreeToFreq(idx, root.midicps, oct).cpsmidi, 127);
				// decay time
				~mc.control(idx, 80, 80.rrand(110));
				// level
				//~mc.control(idx, 95, 80.rrand(100));
			};
		};
	}, '/cluster');


	~sc3Brown = Pwalk(~sc3blg, Pmeanrand(-20, 20), -1, ~sc3blg.size.rand).asStream;

	OSCdef(\sc3walk, {
		Synth(\sc3sampplay, [
			\buf, ~sc3Brown.next,
			\sus, 4.0.exprand(6.0),
			\rel, 1,
			\amp, 1
		]);
	}, '/walk');


	MIDIdef.cc(\sc3SingleMelody, { |val|
		if (val.asBoolean){
			"Scene 3 single melody on".postln;
			~ms.program(7, 4);
			~sc3Textures.at(\singleMelody).play;
			~sc3Textures.at(\brassage).play;
		}{
			"Scene 3 single melody off".postln;
			~sc3Textures.at(\singleMelody).pause;
			~sc3Textures.at(\brassage).pause;
		};
	}, 17, 2);

	MIDIdef.cc(\sc3BigCluster, { |val|
		if (val.asBoolean) {
			"Scene 3 big cluster on".postln;
			~ms.program(7, 4);
			~sc3Textures.at(\bigCluster).play;
			~sc3Textures.at(\brassage).play;
		}{
			"Scene 3 big cluster off".postln;
			~sc3Textures.at(\bigCluster).pause;
			~sc3Textures.at(\brassage).pause;
		};
	}, 18, 2);

	MIDIdef.cc(\sc3BigClusterBass, { |val|
		if (val.asBoolean) {
			"Scene 3 big cluster + bass on".postln;
			~mc.program(7, 2);
			~sc3Textures.at(\bigCluster).play;
			~sc3Textures.at(\bass).play;
		}{
			"Scene 3 big cluster off".postln;
			~sc3Textures.at(\bigCluster).pause;
			~sc3Textures.at(\bass).pause;
		};
	}, 19, 2);


	// Jadi scene 4

	MIDIdef.cc(\sc3Impressionist, { |val|
		if (val.asBoolean) {
			"Scene 3 impressionist on".postln;
			~mc.program(7, 3);
			~ms.program(7, 4);
			6.do { |ch| ~mc.control(ch, 67, 0)};
			~sc3Textures.at(\cluster).set(\gate, 1).run(true);
			~sc3Textures.at(\walk).set(\gate, 1).run(true);
			~sc3Textures.at(\brassage).play;
			~sc3Textures.at(\kempul).play;
		}{
			"Scene 3 impressionist off".postln;
			~sc3Textures.at(\cluster).set(\gate, 0).run(false);
			~sc3Textures.at(\walk).set(\gate, 0).run(false);
			~sc3Textures.at(\brassage).pause;
			~sc3Textures.at(\kempul).pause;
		};
	}, 20, 2);


	"Scene 3 structures are loaded".postln;
};


ServerTree.add(~sc3DefStructures);