# Timing_Circuit_hw01

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
