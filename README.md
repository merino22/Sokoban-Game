# Sokoban-Game
Sokoban is a puzzle video game genre in which the player pushes crates or boxes around in a warehouse, trying to get them to storage locations. 
The game winning condition is reached when all the storage locations have been filled with a box.

The game is played on a board of squares, where each square is a floor or a wall. Some floor squares contain boxes, and some floor squares are marked as storage locations.

The player is confined to the board and may move horizontally or vertically onto empty squares (never through walls or boxes). The player can move a box by walking up to it and push it to the square beyond. Boxes cannot be pulled, and they cannot be pushed to squares with walls or other boxes. The number of boxes equals the number of storage locations. The puzzle is solved when all boxes are placed at storage locations. 

## Development Tools

This game is developed using EasyASM, a simulator for a subset of MIPS32 and x86 ISAs by Ideras(https://github.com/ideras/EasyASM) - with the help of a syscall-handling library and also rlutil library by Tapio(https://github.com/tapio/rlutil). The reach of the development of this game is to at least fully develope three playable levels.

## Usage

### Steps to run Sokoban Game in your system
 
- Make sure you have EasyASM project installed (Link provided Above), with set environment variable.

- To be able to make use of syscall library provided in the project you'll need to make sure to hace cmake installed in your system.

- Clone project to your local file system using repository's .git file.

- Once you've cloned the project successfully, 

### Checking for CMake Installation
Type following command in terminal
```bash 
$ cmake --version
```
