# Desktop Cat 2.3.1

![alt text](Cat1.gif)

## Description

An animated desktop pet in the form of a black cat, with some added funtionality for taking notes. Based on an image I found from [Pinterest](https://mx.pinterest.com/pin/362117626308721718/) that depicts [Luo Xiaohei](ttps://luoxiaohei.fandom.com/wiki/Solar_Terms)(which I only found out after making all the assets).

## Features

### Screen Overlay

This application was programmed such that the window is transparent and only takes up a portion of the screen. Because the window is square and does not allow mouse input to pass through, some transparent areas will still not register mouse imput.

The window containing the application will appear over all items on the screen so you can always see it and interact with it. It can sometimes interfere with tasks so there is an option to make the mouse pass though the window in the settings. If this is done the application can only be closed though the taskbar.

### Movable

![alt text](Cat_Bounce.gif)

Drag the cat around using LMB. Letting go with enough momentum will cause it to continue moving and bounce off the edges of the screen. It will gradually slow down until it reaches a minimum speed and will not stop until the user interacts with it. Should work for all screen sizes and shapes.

Letting go at lower speeds will leave the cat in the position it was dragged to.

Under the hood the actual object being moved is the window, not the sprite.

### Animations

Cat has blinking, twitching, eye animations, and steam particles programmed. When the menu is open the eyes will follow the cursor.

### Menu

![alt text](Cat_Menu.gif)

Right click to open a menu with the following options. The window will stop moving but can still be dragged.

### Notes

![alt text](Cat_Notes.gif)

Write down notes. Position is saved by session and the text is always saved.

### Dictionary

![alt text](Cat_Dict.gif)

Another way to write down notes. Each page has a title, tags, and a main body.
You can add/remove pages and re-order pages.
The search bar will find pages by title and tags, not content.
Pages are saved.


### Settings

![alt text](Cat_Options.gif)

Size, outline thickness, and other settings can be edited. Close the application from this page.
Settings are saved.

## Installation

'Desktop Cat 2.3.1.exe' and 'mouse_passthrough.windows.template_release.x86_64' need to be in the same folder, doesn't matter where. You can create a shortcut to 'Desktop Cat 2.3.1.exe' and place it somewhere on your desktop if desired.

## Usage

Mostly just for entertainment. The notes and dictionary were added since I thought it'd be cool if I could use this to help me solve puzzles and escape rooms, though it could also be used for other things.

## Authors and acknowledgment

#### Prototype was based on:

https://www.digikey.com/en/maker/projects/desktop-pet/994f9b5997fa4d6899c022c9b23724a6

#### Shaders I used (Modified with AI):

* https://godotshaders.com/shader/rainbow-changes-based-off-y-position/
* https://godotshaders.com/shader/outline-that-disrespects-boundaries/
* https://godotshaders.com/shader/simple-hue-shift/

#### Art and UI made by me

#### All code was written by me, except for what remains of [Odd_Jayy's](https://www.digikey.com/en/maker/profiles/55b96932eee744aaa472df702557cac3) original project.
