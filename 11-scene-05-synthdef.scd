SynthDef(\sc5play, {
	var sig = PlayBuf.ar(2, \buf.kr(0));
	var env = Env([0, \amp.kr(1), \amp.kr(1), 0], [0.01, \sus.kr(1), 0.01]).kr(2);
	sig = sig * env;
	sig = Pan2.ar(sig, \pan.kr(0));
	Out.ar(\out.kr(0), sig);
}).add;


SynthDef(\sc5grainTexture, {
	var buf = \buf.kr(0);
	var dens = \density.kr(200);
	var trig = Dust.ar([dens, dens*1.01]);

	var trajectory = Line.ar(
		Rand(0, 0.9*BufSamples.kr(buf)),
		BufSamples.kr(buf) -1,
		10.pow(2) * BufDur.kr(buf),
		doneAction: 2
	) / BufSamples.ir(buf);

	var sig = GrainBuf.ar(
		2, //buf.numChannels,
		trig,
		LFNoise0.ar(dens).range(\lenmin.kr(0.05), \lenmax.kr(0.1)), // grain dur
		buf,
		\bufrate.kr(1)*BufRateScale.kr(buf), // grain rate
		trajectory, // grain position
		2
	);


	var amp = \amp.kr(1);
	var env = Env([0, amp, amp, 0], [\atk.kr(4), \sus.kr(8), \rel.kr(4)], [1, 1, -2]).kr(2);

	sig = HPF.ar(sig, 200);
	sig = Limiter.ar(sig, 0.9);

	Out.ar(\out.kr(0), sig*env);
}).add;


"Scene 5 synth defs are loaded".postln;