//SUPERSINE
(
SynthDef(\supersine, { |out, sustain = 1, freq = 440, speed = 1, decay=0, pan, accelerate, offset, divfreq = 1, mulfreq = 1|
	var env, sound, amp;
	env = EnvGen.ar(Env.pairs([[0,0],[0.007,1],[0.2,1-decay],[0.95,1-decay],[1,0]], -3), timeScale:sustain, doneAction:2);
	freq = freq/divfreq*mulfreq;
	amp = 1/divfreq/mulfreq;
	sound = SinOsc.ar((freq*speed),0,env,0)*amp;
	OffsetOut.ar(out,
		DirtPan.ar(sound, ~dirt.numChannels, pan, env)
	)
}).add
);

//whitenoise
(
SynthDef(\whitenoise, { |out, sustain = 1, freq = 440, speed = 1, decay=0, pan, accelerate, offset|
	var env, sound, amp;
	env = EnvGen.ar(Env.pairs([[0,0],[0.007,1],[0.2,1-decay],[0.95,1-decay],[1,0]], -3), timeScale:sustain, doneAction:2);
	sound = WhiteNoise.ar(env,0)*0.6;
	OffsetOut.ar(out,
		DirtPan.ar(sound, ~dirt.numChannels, pan, env)
	)
}).add
);

(
SynthDef(\impulse, { |out, sustain = 1, freq = 440, speed = 1, decay=0, pan, accelerate, offset, divfreq = 1, mulfreq = 1|
	var env, sound;
	env = EnvGen.ar(Env([1,1,0],[1,1]), timeScale:sustain, doneAction:2);
	freq = freq;
	sound = Impulse.ar(0);
	OffsetOut.ar(out,
		DirtPan.ar(sound, ~dirt.numChannels, pan, env)
	)
}).add
);

(
SynthDef(\impulsekr, { |out, sustain = 1, freq = 440, speed = 1, decay=0, pan, accelerate, offset, divfreq = 1, mulfreq = 1|
	var env, sound;
	env = EnvGen.ar(Env([1,1,0],[1,1]), timeScale:sustain, doneAction:2);
	freq = freq;
	sound = EnvGen.ar(Env.new([0,1,0],[0,10/1000]),doneAction:2);
	OffsetOut.ar(out,
		DirtPan.ar(sound, ~dirt.numChannels, pan, env)
	)
}).add
);


(
SynthDef(\puresaw, { |out, sustain = 1, freq = 440, speed = 1, decay=0, pan, accelerate, offset, divfreq = 1, mulfreq = 1|
	var env, sound, amp;
	env = EnvGen.ar(Env.pairs([[0,0],[0.007,1],[0.2,1-decay],[0.95,1-decay],[1,0]], -3), timeScale:sustain, doneAction:2);
	freq = freq/divfreq*mulfreq;
	amp = 1/divfreq/mulfreq;
	sound = SawDPW.ar((freq*speed),0,env)*amp;
	OffsetOut.ar(out,
		DirtPan.ar(sound, ~dirt.numChannels, pan, env)
	)
}).add
);

(
SynthDef(\purepwm, { |out, sustain = 1, freq = 440, speed = 1, decay=0, pan, accelerate, offset, divfreq = 1, mulfreq = 1, width = 0.5|
	var env, sound, amp;
	env = EnvGen.ar(Env.pairs([[0,0],[0.007,1],[0.2,1-decay],[0.95,1-decay],[1,0]], -3), timeScale:sustain, doneAction:2);
	freq = freq/divfreq*mulfreq;
	amp = 1/divfreq/mulfreq;
	sound = PulseDPW.ar((freq*speed),width,env)*amp;
	OffsetOut.ar(out,
		DirtPan.ar(sound, ~dirt.numChannels, pan, env)
	)
}).add
);