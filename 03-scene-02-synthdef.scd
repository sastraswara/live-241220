SynthDef(\onsetDetector, {
	var buf = \buf.kr(0);
	var sig = PlayBuf.ar(buf.numChannels, buf, BufRateScale.ir(buf), loop: 1);
	var feature = FluidOnsetFeature.kr(sig, 9);
	var env = Env.asr(1, 1, 1, [2, -2]).kr(1, \gate.kr(0));
	var trig = Schmidt.kr(feature, 0.01, \threshold.kr(0.08));
	SendReply.kr(trig, "/onset");
	sig = sig * env;
}).add;


SynthDef(\grainPerc, {
	var buf = \buf.kr(0);
	var dens = \density.kr(60);
	var trig = Impulse.ar([dens, dens*1.01]);

	var trajectory = (
		Line.ar(
			Rand(0, 0.9*BufSamples.ir(buf)),
			BufSamples.ir(buf) -1,
			\durstretch.kr(100) * BufDur.ir(buf),
			doneAction: 2
		)
		+ LFNoise1.ar(100).bipolar(0.01 * SampleRate.ir)
	) / BufSamples.ir(buf);

	var sig = GrainBuf.ar(
		buf.numChannels,
		trig,
		\graindur.kr(0.05), // grain dur
		buf,
		\bufrate.kr(1)*BufRateScale.ir(buf), // grain rate
		trajectory, // grain position
		2
	);

	var env = Env.perc(0.01, \dur.kr(1), \amp.kr(1)).kr(2);

	sig = sig * env;

	Out.ar(\out.kr(0), sig);
}).add;


SynthDef(\grainTexture, {
	var buf = \buf.kr(0);
	var dens = \density.kr(200);
	var trig = Dust.ar([dens, dens*1.01]);

	var trajectory = Line.ar(
		Rand(0, 0.9*BufSamples.ir(buf)),
		BufSamples.ir(buf) -1,
		10.pow(2) * BufDur.ir(buf),
		doneAction: 2
	) / BufSamples.ir(buf);

	var sig = GrainBuf.ar(
		buf.numChannels,
		trig,
		LFNoise0.ar(dens).range(\lenmin.kr(0.05), \lenmax.kr(0.1)), // grain dur
		buf,
		\bufrate.kr(1)*BufRateScale.ir(buf), // grain rate
		trajectory, // grain position
		2
	);

	var amp = \amp.kr(1);
	var env = Env([0, amp, amp, 0], [\atk.kr(4), \sus.kr(8), \rel.kr(4)], [1, 1, -2]).kr(2);

	Out.ar(\out.kr(0), sig*env);
}).add;


"Scene 2 synth defs are loaded".postln;