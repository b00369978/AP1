public class Sound extends Chubgraph
{
   // play with AM sound3.ck has control add random
   // Modulation index = modulator gain/carrier gain (1)

   SinOsc piano => Gain AM => ADSR env => Gain velocity => outlet; 
   SinOsc mod => Gain modamp => AM;

   AM.op(3);// multiply inputs 

    //adsr initial values
    0.005 => float a;
    0.02  => float d;
    0.5  => float s;
    0.1  => float r;
    // min-max values for adsr  
    0.005 => float amin;
    0.2  => float amax;
    0.02  => float dmin;
    0.1  => float dmax;
    0.1  => float smin;
    1.0  => float smax;
    0.1  => float rmin;
    1.0  => float rmax;

    0.0 => float detune;
    0.0 => float derate;
    0.8 => float deratemax;
    1.2 => float deratemin;
    0.98 => float detunemax;
    1.02 =>  float detunemin;

    // min-max values for mamp
    0.0 => float modampgainmin;
    1.2 => float modampgainmax;// > 1 will overmodulate and distort https://electronicspost.com/modulation-index-or-modulation-factor-of-am-wave/ 

    400 => float pianofreq;
    5.0 => float modfreq;
    // min-max values for mod frequency (small range gives tremulo,  large range gives AM)  
    0.0 => float modfreqmin;
    5.0 => float modfreqmax;

    // initial state
    env.set(a :: second, d :: second, s, r :: second);
    modfreq => mod.freq;
    pianofreq => piano.freq;
    0.5 => modamp.gain;


   function void noteOn(float vel ){
       Math.random2f(deratemin, deratemax) => derate;
       modfreq * derate => mod.freq; 
       Math.random2f(detunemin, detunemax) => detune;
       pianofreq * detune => piano.freq; 
       vel => velocity.gain; 
       1 => env.keyOn;}// vel = 0 - 1
   
   function void noteOff(float vel){1 => env.keyOff;}
   
   function void setFreq(float Hz){Hz => pianofreq;}
   
   // name controllable elements of sound
   ["attack","decay","sustain","release","mod freq","mod amp"] @=> string controls[];    
     
   // define control functions specific to instrument
   function void soundControl(int index, float value){  // value 0 - 127
       if(index == 0){amin + ((value/127)*(amax - amin)) => a; env.set(a :: second, d :: second, s, r :: second);} //a
       if(index == 1){dmin + ((value/127)*(dmax - dmin)) => d; env.set(a :: second, d :: second, s, r :: second);} //d
       if(index == 2){smin + ((value/127)*(smax - smin)) => s; env.set(a :: second, d :: second, s, r :: second);} //s
       if(index == 3){rmin + ((value/127)*(rmax - rmin)) => r; env.set(a :: second, d :: second, s, r :: second);} //r
       if(index == 4){modfreqmin + ((value/127)*(modfreqmax - modfreqmin)) => modfreq;}
       if(index == 5){modampgainmin + ((value/127)*(modampgainmax - modampgainmin)) => modamp.gain;}
       
   }
   
   
}