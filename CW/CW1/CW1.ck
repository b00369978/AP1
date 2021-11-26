//CW1

1.05946309  => float semitone;
128 => float tempo;

60/(tempo * 192) => float tick;
// 384 * tick :: second => dur minim;
// 288 * tick :: second => dur crotchetD;
// 192 * tick :: second => dur crotchet;
// 96  * tick :: second => dur quaver;

// Midi notes   57 59 61 62 64 66 68 69
// note name    A  B  C# D  E  F# G# A

[ 67,  67,  69,  69,  71,  71,  67,  67,  66,  66,  64,  64,  62,  67 ] @=> int melNotes[];
[ 96, 96, 96, 96, 96, 96, 96, 96, 96, 96, 96, 96, 192, 192 ] @=>int myDurs[];
[1.0, 1.0, 1.0, 1.0 ,1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0] @=> float myVelocities[];


TriOsc s => dac;
0.2 => s.gain ;

for (1 => int i; i <= 4; i++) {// four repeats
    for (0 =>int index; index < melNotes.cap(); index ++){ //for each element of the array
        Std.mtof(melNotes[index])      => s.freq;
        myVelocities[index]   * 0.2    => s.gain;
        myDurs[index] * tick :: second => now;
    }
}