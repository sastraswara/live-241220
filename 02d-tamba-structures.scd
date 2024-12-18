~tambaDefStructures = {
	MIDIdef.cc(\tambaRebabWalk, { |val|
		if (val.asBoolean) {
			"Tamba rebab walk on".postln;
			~tambaTextures.at(\rebabWalk).play;
		}{
			"Tamba rebab walk off".postln;
			~tambaTextures.at(\rebabWalk).pause;
		};
	}, 1, 2);

	MIDIdef.cc(\rebabCluster, { |val|
		if (val.asBoolean) {
			"Tamba rebab cluster on".postln;
			~tambaTextures.at(\rebabCluster).play;
		}{
			"Tamba rebab cluster off".postln;
			~tambaTextures.at(\rebabCluster).pause;
		};
	}, 2, 2);

	MIDIdef.cc(\rebabPartials, { |val|
		if (val.asBoolean) {
			"Tamba rebab partials on".postln;
			~tambaTextures.at(\rebabPartials).play;
		}{
			"Tamba rebab partials off".postln;
			~tambaTextures.at(\rebabPartials).pause;
		};
	}, 3, 2);

	MIDIdef.cc(\rebabSenggrengan, { |val|
		if (val.asBoolean) {
			"Tamba rebab senggrengan on".postln;
			~tambaTextures.at(\rebabSenggrengan).play;
		}{
			"Tamba rebab senggrengan off".postln;
			~tambaTextures.at(\rebabSenggrengan).pause;
		};
	}, 4, 2);

	MIDIdef.cc(\rebabDrone, { |val|
		if (val.asBoolean) {
			"Tamba rebab drone on".postln;
			~tambaTextures.at(\rebabDrone).play;
		}{
			"Tamba rebab drone off".postln;
			~tambaTextures.at(\rebabDrone).pause;
		};
	}, 5, 2);

	MIDIdef.cc(\stochasticRun, { |val|
		if (val.asBoolean) {
			"Tamba stochastic run on".postln;
			~tambaTextures.at(\stochasticRun).reset.play;
		}{
			"Tamba stochastic run off".postln;
			~tambaTextures.at(\stochasticRun).stop;
		};
	}, 6, 2);

	MIDIdef.cc(\stochasticBounce, { |val|
		if (val.asBoolean) {
			"Tamba stochastic bounce on".postln;
			~tambaTextures.at(\stochasticBounce).reset.play;
		}{
			"Tamba stochastic bounce off".postln;
			~tambaTextures.at(\stochasticBounce).stop;
		};
	}, 7, 2);

	MIDIdef.cc(\layers, { |val|
		if (val.asBoolean) {
			"Tamba layers on".postln;
			~tambaTextureLayers.do { |rout| rout.reset.play };
		}{
			"Tamba layers off".postln;
			~tambaTextureLayers.do { |rout| rout.stop };
		};
	}, 8, 2);

	"Tamba structures are loaded".postln;
};


ServerTree.add(~tambaDefStructures);

