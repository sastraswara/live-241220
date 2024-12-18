MIDIClient.init;
MIDIIn.connectAll;
//MIDIClient.destinations;

// Check whether in mac or in linux!
~mc = MIDIOut.newByName(
	"Elektron Model:Cycles",
	"Elektron Model:Cycles"
);

~ms = MIDIOut.newByName(
	"Elektron Model:Samples",
	"Elektron Model:Samples"
);

// ini mesti di-assign ke tombol midi juga
~panicButton = {
	MIDIdef.cc(\panicButton, {
		"All notes off".postln;
		6.do {  |ch| ~mc.allNotesOff(ch) };
		6.do {  |ch| ~ms.allNotesOff(ch) };
	}, 40, 2);
};

ServerTree.add(~panicButton);

"MIDI Setup is loaded".postln;