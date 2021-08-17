# Assembly Snake Game

A classic Snake game implemented in x86 Assembly language. This project was developed as part of my university coursework to demonstrate low-level programming skills and hardware interaction.

![Snake Game](assets/screenshots/placeholder.png)

## Features

- Fully functional Snake game with intuitive controls
- Menu system with multiple options
- Score tracking system
- Colorful graphics using VGA mode
- Smooth snake movement and collision detection
- Food generation system

## Technical Details

This game was developed using:
- x86 Assembly language
- TASM (Turbo Assembler)
- DOS environment
- VGA graphics mode (640x480 pixels)
- Interrupt-based keyboard input

## Controls

- **Arrow Keys**: Control snake direction
- **Enter**: Select menu options
- **Esc**: Exit game

## Implementation Highlights

- **Graphics Rendering**: Custom pixel-by-pixel rendering of the snake, food, and UI elements
- **Memory Management**: Efficient use of memory for storing game state
- **Interrupt Handling**: Direct hardware interaction for keyboard input
- **Game Logic**: Implementation of classic snake game mechanics including:
  - Movement and direction control
  - Collision detection
  - Score tracking
  - Food generation

## Building and Running

To run this game, you'll need:
1. TASM (Turbo Assembler) or compatible assembler
2. DOS environment or DOSBox emulator

### Assembly and Execution

## Installation

1. Clone this repository:
   ```
   git clone https://github.com/yourusername/SnakeGame.git
   ```

2. Make sure you have TASM (Turbo Assembler) installed or use DOSBox with TASM.

3. Navigate to the source directory:
   ```
   cd SnakeGame/src
   ```

4. Assemble and link the program:
   ```
   tasm FinalSnakeGame.asm
   tlink FinalSnakeGame.obj
   ```

5. Run the executable:
   ```
   FinalSnakeGame.exe
   ```
