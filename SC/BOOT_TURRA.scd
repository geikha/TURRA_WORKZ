(
s = s ? Server.default;

s.options.memSize = 8192*48;
s.options.numWireBufs = 256*6;
s.options.numBuffers = 1024*32;
s.options.blockSize = 32;
s.options.numOutputBusChannels = 4;

~samplesPath = PathName.new("/path/to/samples/*"); // change me!
~synthPath = PathName.new("/path/to/synthdefs/*");

s.waitForBoot {

	~dirt.free;
	~dirt = SuperDirt.new(2, s);
	~numberOfOrbits = 14;
	//~orbits = {Bus.audio(s,2)}!~numberOfOrbits; // for recording use

	s.sync;

	~dirt.doNotReadYet = true;

	// SAMPLE LOADING
	~nameFunc  = { |x| x.basename.replace("-","")};
	~dirt.loadSoundFiles(path.fullPath, false, ~nameFunc);

	~synthPath.asAbsolutePath.loadPaths;

	s.sync;

	~dirt.start(57120, (0!~numberOfOrbits));

	// for recording use
	//~dirt.start(57120, ~orbits);
	//~orbits.do{ |bus, i| bus.play(~dirt.group,0) };
};
);

/* for recording use only
(
~recordName = "TURRA";
~recordOrbits = 14;
~recordPath = "C:\\Users\\ritch\\Documents\\Tidal Projects\\RECORD\\" ++ ~recordName;
~recorders = {Recorder.new(s)}!~recordOrbits;
~recorders.do{ |rec, i|
	var namepath = ~recordPath++"\\"++~recordName++"_ORBIT_"++i.asString++".wav";
	rec.record(namepath,~orbits[i],2);
};
);

(
~recorders.do{ |rec,i| rec.stopRecording }
)
*/
