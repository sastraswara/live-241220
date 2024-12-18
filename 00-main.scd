(
"01-init.scd".loadRelative;

s.waitForBoot({
	"02-midi-setup.scd".loadRelative;
	s.sync;

	// Tamba
	"02a-tamba-synthdef.scd".loadRelative;
	"02b-tamba-buffer.scd".loadRelative;
	s.sync;
	"02c-tamba-textures.scd".loadRelative;
	"02d-tamba-structures.scd".loadRelative;

	// Play for the gods scene 2
	"03-scene-02-synthdef.scd".loadRelative;
	"04-scene-02-buffer.scd".loadRelative;
	s.sync;
	"05-scene-02-textures.scd".loadRelative;
	"06-scene-02-structrures.scd".loadRelative;

	// Play for the gods scene 3
	"07-scene-03-synthdef.scd".loadRelative;
	"08-scene-03-buffer.scd".loadRelative;
	s.sync;
	"09-scene-03-textures.scd".loadRelative;
	"10-scene-03-structures.scd".loadRelative;

	// Play for the gods scene 5 - electronic
	"11-scene-05-synthdef.scd".loadRelative;
	"12-scene-05-buffer.scd".loadRelative;
	s.sync;
	"13-scene-05-textures.scd".loadRelative;
	"14-scene-05-structures.scd".loadRelative;

	ServerTree.run;
	s.sync;

	"Setup complete".postln;
	"---".postln;
})
)

//~panicButton.();