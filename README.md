MouseClickBuilder – Complete User Guide
MouseClickBuilder lets you create 2‑button keyboard combinations that trigger automatic mouse clicks at exact screen locations, regardless of what window is active.
It is designed for commercial control boxes, kiosks, and simulator environments where users need fast, reliable, window‑independent clicking.
The system uses absolute screen coordinates, includes a built‑in delay, and hides the cursor after clicking.

📁 Folder Structure
Your GitHub repository should contain:
/MouseClickBuilder
    MouseClickBuilder.ahk      ← main program users run
    GeneratedHotkeys.ahk       ← auto-created file storing all hotkeys


Both files must remain in the same folder.
- MouseClickBuilder.ahk is the builder tool.
- GeneratedHotkeys.ahk is created automatically and stores all hotkeys permanently.

▶️ Starting MouseClickBuilder
- Install AutoHotkey v1.1 (not v2).
- Double‑click MouseClickBuilder.ahk.
- You will see the main window:
Pick a screen location, then assign a key combo.
[ Pick Screen Location ]
[ Done Adding Hotkeys ]


This window stays open so you can add unlimited hotkeys.

🎯 Creating a Hotkey (Step‑by‑Step)
1. Click “Pick Screen Location”
The program will display:
Click anywhere on the screen...


Move your mouse to the exact spot you want the automated click to happen, then left‑click.
MouseClickBuilder records the absolute screen coordinates.

2. Press your 2‑button keyboard combination
Immediately after selecting the screen location, a small window appears:
Please press the 2-button combination you want to activate this click...


Press the two keys you want to use as the hotkey.
Examples:
- a + up
- k + o
- 1 + right
- space + enter
The tool:
- Captures the keys live
- Displays each key as you press it
- Automatically assigns:
- First key → modifier
- Second key → activator
No typing is required.

3. Hotkey is instantly created
Once both keys are pressed:
- The hotkey is written into GeneratedHotkeys.ahk
- The hotkey becomes active immediately
- The main window stays open so you can add more
No reloads. No restarts. No interruptions.

🖱️ What Each Hotkey Does
Every hotkey performs the same sequence:
- Moves the mouse to the saved screen location
- Waits ~0.4 seconds
- Performs a left‑click
- Moves the mouse to the upper‑left corner (0,0) to hide it
This behavior is embedded directly into the generated file.

📄 What GeneratedHotkeys.ahk Looks Like
Each hotkey is stored as a fully self‑contained block:
~a & up::
    CoordMode, Mouse, Screen
    CoordMode, Click, Screen
    MouseMove, 2292, 615, 0
    Sleep, 400
    Click, 2292, 615
    MouseMove, 0, 0, 0
Return


This ensures:
- Absolute screen coordinates
- Independent operation
- No reliance on the builder
- Works even if the builder is closed
- Works on any Windows machine

🛑 Finishing Your Session
When you’re done adding hotkeys:
- Click Done Adding Hotkeys
- MouseClickBuilder closes
- Your hotkeys remain active as long as GeneratedHotkeys.ahk is running
You can run GeneratedHotkeys.ahk by itself anytime.

🔧 Adding More Hotkeys Later
Just run MouseClickBuilder.ahk again.
- Existing hotkeys remain untouched
- New hotkeys are appended
- Everything stays modular and safe

