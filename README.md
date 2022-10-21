# Timing_Circuit_hw01 8-bit Root-Mean-Square calculator

## States

| State | function | Cycles |
| :-----:| :----: | :----: |
| S0 | wait | 1 |
| S1 | update Sum register | 1 |
| S2 | division | Width + fraction bit + 2|
| S3 | sqrare root | (Width + fraction bit)/2 + 2 |


In this design, width = 20, fraction bit = 4.

Therefore, it needs 1+1+26+14 = 42 clock cycles to complete one input.

![image](https://github.com/JimHui0/Timing_Circuit_hw01/blob/main/state.jpg)

## Simulation Result

Using test sequence {42, 45, 47, 51, 49, 50}.

Since this homework require fraction bit = 4, the smallest step in fraction part is 2^-4 = 0.0625.

Because of that, even though the exact RMS of test sequence is 47.4342, this design can only come close to 47.375.

![image](https://github.com/JimHui0/Timing_Circuit_hw01/blob/main/sim_result.png)
