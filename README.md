# Two test tasks on Lua
### 1

For a number written in Roman numerals to be considered valid there are basic rules which must be followed. Even though the rules allow some numbers to be expressed in more than one way there is always a "best" way of writing a particular number.  
For example, it would appear that there are at least six ways of writing the number sixteen:
```
IIIIIIIIIIIIIIII
VIIIIIIIIIII
VVIIIIII
XIIIIII
VVVI
XVI
```
However, according to the rules only XIIIIII and XVI are valid, and the last example is considered to be the most efficient, as it uses the least number of numerals.

The 11K text file, roman.txt (right click and 'Save Link/Target As...'), contains one thousand numbers written in valid, but not necessarily minimal, Roman numerals; see About... Roman Numerals for the definitive rules for this problem.

Find the number of characters saved by writing each of these in their minimal form.

Note: You can assume that all the Roman numerals in the file contain no more than four consecutive identical units.


### 2
There is a text file Maze.txt. It contain the maze in a specific format.  
Symbol:
```
0 - not passable area (wall).
Space - passable area.  
I - entrance to the maze.  
E - exit from the maze.
```
Write a program that determines the shortest path in the maze from I to E, and displays it in another text file. You can use any path finding algorithm. The program should be able to work with any file-maze, which is built on the principle of the test. We believe that outside the labyrinth everything is filled with zeros (wall), even if the example already has zeros at the edges of the maze.
