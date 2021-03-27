# Sokoban-Game
Sokoban is a puzzle video game genre in which the player pushes crates or boxes around in a warehouse, trying to get them to storage locations. 
The game winning condition is reached when all the storage locations have been filled with a box.

The game is played on a board of squares, where each square is a floor or a wall. Some floor squares contain boxes, and some floor squares are marked as storage locations.

The player is confined to the board and may move horizontally or vertically onto empty squares (never through walls or boxes). The player can move a box by walking up to it and push it to the square beyond. Boxes cannot be pulled, and they cannot be pushed to squares with walls or other boxes. The number of boxes equals the number of storage locations. The puzzle is solved when all boxes are placed at storage locations. 

## Development Tools

This game is developed using EasyASM, a simulator for a subset of MIPS32 and x86 ISAs by Ideras(https://github.com/ideras/EasyASM) with the help of a syscall-handling library and also rlutil library by Tapio(https://github.com/tapio/rlutil). The reach of this game's development is to at least fully create three playable levels.

- Update: Final game has ten playable Games

## Usage

### Steps to run Sokoban Game in your system
 
1. Make sure you have EasyASM project installed (Link provided Above), with set environment variable

2. To be able to make use of syscall library provided in the project you'll need to make sure to hace cmake installed in your system

3. Download zip file or Clone project to your local file system using repository's .git file(https://github.com/merino22/Sokoban-Game.git)
```bash
$ git clone 
```

4. Once you've cloned the project successfully, locate yourself inside project dir and create build folder

```bash
$ cd /home/user/Sokoban-Game
$ sudo mkdir build
```
5. Locate yourself inside build dir and run CMake command
```bash
$ cd build
$ cmake ../
```
Output: 

![Sokoban (2)](https://user-images.githubusercontent.com/47042092/112726639-1de27480-8ee4-11eb-9356-18b96a87d9f5.png)

6. Right after run make command: 
```bash
$ make
```
Output:

![Sokoban (3)](https://user-images.githubusercontent.com/47042092/112726646-2cc92700-8ee4-11eb-9b18-ff9fcb99c5bd.png)

7. Go back to Sokoban-Game dir, and run the following in your terminal in full screen mode: 

```bash 
$ EasyASM --sc-handler ./build/libsc-plugin.so --run ./SokobanGame/Sokoban.asm ./SokobanGame/Maps.asm SokobanGame/Figures.asm
```
8. Sokoban Game should be up and running! Have fun!

## Recommendations
Running Sokoban on VSCode terminal will give the game an overall better aesthetic
Running Sokoban with your terminal in full screen mode will give the game an overall better aesthetic

## Checking for EasyASM & CMake Installation
To check EasyASM type following command in terminal
```bash
$ EasyASM
```
If EasyASM is installed in your system, the next ouput will be prompted:
![Screenshot from 2021-03-27 10-40-05](https://user-images.githubusercontent.com/47042092/112727654-1e313e80-8ee9-11eb-8cc1-4eff134dbf5a.png)

To check CMake type following command in terminal
```bash 
$ cmake --version
```
