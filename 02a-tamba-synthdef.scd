SynthDef(\tambaVosc, {
	var env = Env(
		[0, 1, 1, 0],
		[\atk.kr(0.01), \sus.kr(1), \rel.kr(0.01)],
		[\c0.kr(1), 0, \c1.kr(-1)]
	).kr(\done.kr(2));

	var detuneCtrl = LFNoise1.kr(0.1!8).bipolar(\detune.kr(0.2)).midiratio;
	var bufpos = \buf.kr(0) + LFNoise1.kr(\interfreq.kr(0.1)!8).range(0, 9);

	var sig = VOsc.ar(bufpos, \freq.kr(200)*detuneCtrl, { Rand(0, 2pi) }!8 );
	sig = Splay.ar(sig);
	sig = LeakDC.ar(sig);
	sig = Balance2.ar(sig[0], sig[1], \pan.kr(0), \amp.kr(0.2));
	sig = sig * env;

	Out.ar(\out.kr(0), sig);
	//Out.ar(\rout.kr(0), sig * \rsend.kr(-20).dbamp);
}).add;


// Percussion player
SynthDef(\tambaPercussionPlayer, {
	var phs = Phasor.ar(
		0,
		BufRateScale.kr(\buf.kr) * \rate.kr(1),
		\start.kr(0) * BufFrames.kr(\buf.kr),
		\end.kr(1) * BufFrames.kr(\buf.kr)
	);
	var sig = BufRd.ar(
		1,
		\buf.kr,
		phs
	);
	var env = Env.perc(\atk.kr(0.01), \rel.kr(1)).kr(2);
	sig = sig * env * \amp.kr(1);
	sig = Pan2.ar(sig, \pan.kr(0));
	Out.ar(\out.kr(0), sig);
}).add;


// Sample Player
SynthDef(\tambaPlayBuf, {
	var sig = PlayBuf.ar(1, \buf.kr, \rate.kr(1)*BufRateScale.kr(\buf.kr), startPos: BufFrames.kr(\buf.kr)*\pos.kr(0), loop: 1);
	var env = Env.linen(\atk.kr(0.01), \sus.kr(1), 0.1).kr(2);
	sig = PitchShift.ar(sig, \win.kr(0.2), pitchRatio: \ratio.kr(1), timeDispersion: \dis.kr(0));
	sig = sig * env * \amp.kr(1);
	sig = Pan2.ar(sig, \pan.kr(0));
	Out.ar(\out.kr(0), sig);
}).add;


// Rebaban wave table
SynthDef.new(\tambaRebaban, {
	arg out=0, buf=0, numBufs=2, freq=300, sus=1,
	amp=0.2, atk=1, rel=3, gate=1, lagtime=0, curvelag=(-4),
	fc=1000, fx=0, fxamp=(-10);
	var sig, bufpos, detuneSig, env;
	// Wavetables
	detuneSig = LFNoise1.kr(0.2!8).bipolar(0.2).midiratio;
	bufpos = buf + LFNoise1.kr(0.5).range(0, numBufs-1);
	sig = VOsc.ar(
		bufpos: bufpos,
		freq: freq.varlag(lagtime, curvelag) * detuneSig;
	);
	// Filter
	sig = LPF.ar(
		in: sig,
		freq: LFNoise2.kr(0.1).range(fc, fc*4);
	);
	//Envelopes
	env = EnvGen.kr(
		Env.asr(
			attackTime: atk,
			sustainLevel: 1,
			releaseTime: rel,
			curve: -4
		),
		gate,
		doneAction: 2
	);
	// Output signal
	sig = Splay.ar(sig);
	sig = LeakDC.ar(sig) * env * amp;
	Out.ar(out, sig);
}).add;

"Tamba synthdefs are loaded".postln;