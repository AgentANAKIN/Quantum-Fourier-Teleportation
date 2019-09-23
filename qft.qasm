OPENQASM 2.0;
include "qelib1.inc";
qreg q[10];
creg c[10];

// set input states for a 001 output
h q[0];
u1(-pi) q[0];
h q[1];
u1(-pi/2) q[1];
h q[2];
u1(-pi/4) q[2];

barrier q; // entangle Alice's (3, 4) and Bob's (5, 6) qubits
h q[3];
cx q[3], q[5];
h q[4];
cx q[4], q[6];

barrier q; // swap q[0] and q[7]
swap q[0], q[3];
cx q[3], q[4];
h q[3];
//measure q[3] -> c[3];
//measure q[4] -> c[4];
swap q[7], q[6];
cx q[6], q[5];
h q[6];
//measure q[5] -> c[5];
//measure q[6] -> c[6];
cx q[4], q[7];
cz q[3], q[7];
cx q[5], q[0];
cz q[6], q[0];

barrier q; // reset Alice's and Bob's qubits
reset q[3];
reset q[4];
reset q[5];
reset q[6];
h q[3];
cx q[3], q[5];
h q[4];
cx q[4], q[6];

barrier q; // swap q[1] and q[8]
swap q[1], q[3];
cx q[3], q[4];
h q[3];
//measure q[3] -> c[3];
//measure q[4] -> c[4];
swap q[8], q[6];
cx q[6], q[5];
h q[6];
//measure q[5] -> c[5];
//measure q[6] -> c[6];
cx q[4], q[8];
cz q[3], q[8];
cx q[5], q[1];
cz q[6], q[1];

barrier q; // reset Alice's and Bob's qubits
reset q[3];
reset q[4];
reset q[5];
reset q[6];
h q[3];
cx q[3], q[5];
h q[4];
cx q[4], q[6];

barrier q; // swap q[2] and q[9]
swap q[2], q[3];
cx q[3], q[4];
h q[3];
//measure q[3] -> c[3];
//measure q[4] -> c[4];
swap q[9], q[6];
cx q[6], q[5];
h q[6];
//measure q[5] -> c[5];
//measure q[6] -> c[6];
cx q[4], q[9];
cz q[3], q[9];
cx q[5], q[2];
cz q[6], q[2];

barrier q; // perform Quantum Fourier Transform (QFT)
h q[7];
cu1(pi/2) q[8], q[7];
cu1(pi/4) q[9], q[7];
barrier q;
h q[8];
cu1(pi/2) q[9], q[8];
barrier q;
h q[9];

barrier q; // measure
measure q[7] -> c[7];
measure q[8] -> c[8];
measure q[9] -> c[9];
