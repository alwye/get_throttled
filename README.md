# get_throttled for humans

`vcgencmd get_throttled` is a command on Raspberry Pi operating system, Raspbian, 
to find out whether the processor has been throttled due to overheating or under-voltage, 
and whether this is still the case. 

Unfortunately, the format of the output is represented is hexadecimal, so I wanted to write a simple script 
that would help to translate this into plain language.

Only runs on platforms, where the command above is legit.
