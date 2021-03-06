//update paths for your machine to point to models and source audio

b = Buffer.read(s, Platform.resourceDir +/+ "sounds/a11wlk01.wav");


(
{
var chain, in;

	//in = SoundIn.ar;
	in = PlayBuf.ar(1,b);

	chain = FFT(LocalBuf(4096), in, 0.5, -1); //rectangular windowing

	//2 layers
	//chain = PV_Kerasify(chain,"/data/durham/grants/MIMIC/KerasToRealTimeAudio/SuperCollider UGen/models/DNNecstasy10epochs.model");
	chain = PV_Kerasify(chain,0,"/data/durham/grants/MIMIC/KerasToRealTimeAudio/SuperCollider UGen/models/DNNecstasy100epochs.model");

	//4 layers
	//chain = PV_Kerasify(chain,0,"/data/durham/grants/MIMIC/KerasToRealTimeAudio/SuperCollider UGen/models/DNNTheHype.model");

	Limiter.ar(IFFT(chain));

}.scope
)


//amortisation version
//flag setting of 15 assumes 2 layer network, 15*2+1 = 31 < (2048/64) = 32
//flag setting of 7 for 4 layer network, 7*4+1 = 29 < (2048/64) = 32

(
{
var chain, in;

	//in = SoundIn.ar;
	in = PlayBuf.ar(1,b);

	chain = FFT(LocalBuf(4096), in, 0.5, -1); //rectangular windowing

	//2 layers
	chain = PV_Kerasify(chain,15,"/data/durham/grants/MIMIC/KerasToRealTimeAudio/SuperCollider UGen/models/DNNecstasy100epochs.model");

	//4 layers
	//chain = PV_Kerasify(chain,7,"/data/durham/grants/MIMIC/KerasToRealTimeAudio/SuperCollider UGen/models/DNNTheHype.model");


	Limiter.ar(IFFT(chain));

}.scope
)