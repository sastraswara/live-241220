SynthDef(\sc3osc, {
	var env = Env(
		[0, 1, 1, 0],
		[\atk.kr(3), \dur.kr(1), \rel.kr(5)],
		[1, -3]).kr(2);
	var numOsc = 4;
	var freqs = \freq.kr(200) * Array.fill(numOsc, { ExpRand(0.99, 1.01) });
	var amps = SinOsc.kr(
		0.2,
		Array.fill(numOsc, { Rand(0, 2pi) })).exprange(0.2, 1);
	var sig = Osc.ar(\buf.kr(0), freqs) * amps;
	sig = Pan2.ar(sig, \pan.kr(0)) * \amp.kr(0.5);
	sig = LeakDC.ar(sig);
	sig = sig * env;
	Out.ar(\out.kr(0), sig);
}).add;


SynthDef(\sc3clusterOnset, { |target|
	var sig = PlayBuf.ar(1, \buf.kr(0), BufRateScale.kr(\buf.kr(0)) * \rate.kr(0.5), loop: 1);
	var onset = FluidOnsetFeature.kr(sig, 9);
	var trig = Schmidt.kr(onset, 0.01, 0.1);
	//var env = Env([0, \amp.kr(0), \amp.kr(0), 0], [0.01, \dur.kr(1), 0.01]).kr(1, 0);

	//sig = sig*env;
	SendReply.kr(trig, "/cluster");
	//Out.ar(\out.kr(0), sig);
}).add;


SynthDef(\sc3walkOnset, { |target|
	var sig = PlayBuf.ar(1, \buf.kr(0), BufRateScale.kr(\buf.kr(0)) * \rate.kr(0.5), loop: 1);
	var onset = FluidOnsetFeature.kr(sig, 9);
	var trig = Schmidt.kr(onset, 0.01, 0.1);
	//var env = Env([0, \amp.kr(0), \amp.kr(0), 0], [0.01, \dur.kr(1), 0.01]).kr(1, 0);

	//sig = sig*env;
	SendReply.kr(trig, "/walk");
	//Out.ar(\out.kr(0), sig);
}).add;


SynthDef(\sc3sampplay, {
	var buf = \buf.kr(0);

	var sig = PlayBuf.ar(
		1,
		buf,
		BufRateScale.kr(buf) * \rate.kr(1),
		startPos: BufFrames.kr(buf) * \pos.kr(0),
		loop: \loop.kr(0),
		doneAction: \done.kr(2)
	);

	var env = Env([0, \amp.kr(1), \amp.kr(1), 0], [\atk.kr(0.01), \sus.kr(1), \rel.kr(0.01)]).kr(2);

	sig = sig * env;
	//sig = Pan2.ar(sig, \pan.kr(0));

	Out.ar(\out.kr(0), sig);
}).add;


"Scene 3 synth defs are loaded".postln;