(
~midside = {|in, msBalance=0|
	var sig = Balance2.ar(in[0] + in[1], in[0] - in[1], msBalance);
	[sig[0] + sig[1], sig[0] - sig[1]] * sqrt ( (msBalance.max(0)+1)/2 )
};
SynthDef.new(\soundgood, {
	| out=0, in=0, wet=0.35, makeup=0.98 |
	var lfreq = 250, hfreq = 3000, q = 1.1;
	var dry, low, mid, high, master;
	var att = 5/1000;
	var lrel = 137/1000, lpre = dbamp(5*wet), lpos = dbamp(5.9*wet), lexp = 0.07*wet, lstereo = -1*wet;
	var mrel = 85/1000, mpre = dbamp(6*wet), mpos = 1, mstereo = 0.38*wet;
	var hrel = 75/1000, hpre = dbamp(6.8*wet), hpos = dbamp(2.9*wet), hexp = 0.14*wet, hstereo = 0.2, hsat = 1/16*wet;
	var output;

	dry = In.ar(in,2);
	dry = BHiPass4.ar(dry,25);

	low = BLowPass4.ar(dry,lfreq,q);
	mid = BHiPass4.ar(dry,lfreq,q); mid = BLowPass4.ar(mid,hfreq,q);
	high = BHiPass4.ar(dry,hfreq,q);

	low = CompanderD.ar(low*lpre,1,1+lexp,10,att,lrel,lpos);
	low = ~midside.(low, lstereo);
	low = SineShaper.ar(low);

	mid = CompanderD.ar(mid*mpre,1,1,10,att,lrel,mpos);
	mid = ~midside.(mid, mstereo);

	high = CompanderD.ar(high*hpre,1,1+hexp,10,att,hrel,hpos);
	high = ~midside.(high, hstereo);
	high = SineShaper.ar(high,hpos-(hpos*hsat));

	master = Limiter.ar(LeakDC.ar(Mix.new([low,mid,high])),0.99,0.01)*makeup;

	Out.ar(out, master);
}).add;
);