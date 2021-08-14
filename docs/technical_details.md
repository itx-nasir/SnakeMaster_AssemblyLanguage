# Snake Game Technical Implementation Details

## Architecture Overview

This Snake game is implemented in x86 Assembly language and designed to run in a DOS environment. The game utilizes VGA graphics mode for display and interrupt-based keyboard input for controls.

## Code Structure

The code is organized into several key procedures:

### Main Game Components
- `main`: Entry point that initializes data segments and sets up the game environment
- `Menu`: Handles the game menu and user selection
- `Run`: Main game loop that manages game state and updates
- `Snake`: Renders the snake head based on current direction
- `Snake_tail`: Renders the snake body segments
- `Create_food`: Manages food generation and placement
- `Score`: Displays and updates the player's score

### Input Handling
- `Check_key`: Processes keyboard input to control snake direction

### Graphics Utilities
- `DrawRec`: Utility for drawing rectangles
- `DrawMenu`: Renders the game menu
- `Clear`: Clears the screen between state changes

## Memory Management

The game uses several data structures to manage game state:
- Snake position tracking via coordinate arrays
- Direction state management
- Score tracking
- Food position management

## Graphics Implementation

The game uses VGA mode 12h (640x480 with 16 colors) for graphics rendering. Key graphical elements include:

1. **Snake Head**: Custom-designed pixel art stored as data bytes
2. **Snake Tail**: Checkered pattern segments that follow the head
3. **Food Items**: Colorful items that appear at random positions
4. **UI Elements**: Score display and menu system

## Interrupt Usage

The game makes extensive use of BIOS and DOS interrupts:
- `INT 10h`: Video services for graphics rendering
- `INT 16h`: Keyboard input
- `INT 21h`: DOS functions
- `INT 15h`: System services (for timing/delay)
