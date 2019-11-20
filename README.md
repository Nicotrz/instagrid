# MyPicturesGrid

> An iOS Photomontage app for the project number 4 of the iOS Developer training program of OpenclassRooms

<a href="https://apps.apple.com/us/app/mypicturesgrid/id1460604439"><img src="https://github.com/Nicotrz/instagrid/blob/master/1200x630wa.png?raw=true" title="MyPicturesGrid" alt="Nicotrz"></a>
<!-- [![FVCproductions](https://github.com/Nicotrz/instagrid/blob/master/1200x630wa.png?raw=true)](https://github.com/Nicotrz) -->

## Setup

To edit the code, just clone the repo.
To use the app, download it for free on the App store

## Features

<img src="https://github.com/Nicotrz/instagrid/blob/master/392x696bb.jpg?raw=true" title="MyPicturesGrid" alt="Nicotrz">

This app let you create simple photomontage with your personnal pictures on iOS.

- Use your own pictures
- 3 dispositions supported for the grid
- Shuffle function to let the app create montages for you
- Share function supported to send the result anywhere you want
- Use the app on portrait or landscape.

## Frameworks:

- Native iOS Photo Framework

## Purpose of the project:

The main project was to reproduce this design received from a Sketch file:
<img src="https://github.com/Nicotrz/instagrid/blob/master/Capture%20d’écran%202019-11-20%20à%2021.31.34.png?raw=true" title="MyPicturesGrid" alt="Nicotrz">

Then make the app works with clean code and architecture (MVC)

## Model View Controller

For the project, this app use the MVC Design Pattern:
- The View handle the transitions between the dispositions, and set the image received from the ViewController
- The Controller handle the communication with the view and the model, the UIGestures done by the user, the photo permissions and dialog boxes, and multithreading for background photos load
- The Model  transform an UIView into a UIImage and an PHPAsset into an UIImage

## Credits

Nicolas Sommereijns - 2019
