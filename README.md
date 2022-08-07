# GCC Extended Assembly in C Language

This project consists in a series of exercises aimed at improve my ability in inline Assembly programming.
The game-goal is to create the _shortest asm code_ possible.
There is no aim to optimize the computing speed.

The chosen syntax is the Intel one.

To compile and run the tasks use the following commands:
```
[make clean;] make task_TASKCODE.bin; ./task_TASKCODE.bin
```
Where ```TASKCODE``` is the integer code of the task.

## Task 1: Date & time extraction from a string

Given a string containing current date and time in the format _DD/MM/YYYY hh:mm:ss_, break it down into days, months, years, hours, minutes and seconds.

The chosen approach consists in iterating the sequence of characters and summing the numeric values, pushing them to the stack when a symbol is met.

Example:
```
1.  31/12/9999 23:59:59
    ^
    ax <- 3
2.  31/12/9999 23:59:59
     ^
    ax <- ax * 10 + 1 = 31
3.
    31/12/9999 23:59:59
      ^
    push ax
    ax <- 0
4.  31/12/9999 23:59:59
       ^
    ax <- 1
5.  ...
n.  31/12/9999 23:59:59
                       ^
    push ax
    pop VARIABLES
```

## Task 2: Points proximity calculation

Provided a set of two-dimensional points in the Cartesian plane, find the closest and the farthest point from a given point (x, y).
Each point is represented by a DWORD: where the least significant WORD is the x coordinate, and the most significant one is the y.

The chosen approach simply consists in calculating the Euclidean distance of the points in the set to the target one. If a nearer or farther point is found, its index is saved.
