# suburban-commando

## Never  fear to pivot!

Make the entities super fudging simple!

## There are no dates in the suburb
The title above references the fact that I did indeed have a date in it, earlier. But not today.

Focus-thing while working in Godot, from the Backlog of All Backlogs:

- [ ] *Player Entity 1*
- [ ] *Enemy Entity 1*
- [ ] Level 2
- [ ] Visual Stylings
- [ ] Shooting
- [x] Level 1

## Enemy Entity 1 <- doing now
### Mechanics
What is the mechanics for this first implementation of enemies in the game? Well, they should be simple, not complicated at all. I would like the enemy to be able to idle, walk, and do some kind of simple attack. I decided to use Mixamo again, but I would like to find some kind of "simpler" character somewhere on the Interwebs to make the next task, having a cool visual style of the game, work. I notice that my work here, compared to the work I did on the other game, is less straight-forward. This is most likely due to me not being comfortable with what I am doing, not really having a *feel* for how the engine actually works. This is fine. So, anyways, I want to have behavior trees as well, so we should look into the absolutely simplest way to get that done in the game.

The enemy should basically only want to do the simplest possible things right now: walk around, searching for player to attack. So, the next step is to import the downloaded asset into Godot and make stuff happen from there. 

- [x] Download asset
- [ ] Import Asset
- [ ] Put in map
- [ ] Attach a behavior tree to it


## Player Entity 1 - done
It would be cool to import a very cool character in the game, but it is absolutely not important. We have a character imported, the roth character. Todo:
- [x] move the player character in / on the level
- [x] show different anims
- [ ] Rotate character in direction of movement - seems very hard. 

## Level 1 - doing now
The reason we need to start work on the level is because without it, there is nothing for the player to move about on. 

* create a simple plane - done
* import some Kenney assets - done

I'm just dictating this because I can't be bothered to write it on a home screen keyboard and more anyways I might not have the time to do free form exploring every time I sit down to work on the game therefore it is very important to decide something to work on for a specific work chunk of time so if I decide for instance to sit down for 45 minutes I should have something decided beforehand to actually work a problem to solve a thing to achieve so like I have been able to import taxes Frances which is really cool mixamo characters oh yeah this was interesting import characters not pay taxes in Francis I've no idea what to do is doing and with so I be imported characters what what is it that I want to do next and it should be related to the game I shouldn't be fiddling about with different animations of stuff I should just work on something so I could try applying applying the cool shade at to the can't drive over to go and I should also try to report the FBI X cuharacter of from Kenny's stuff because they're more cartoons fits better than I should wasn't try to pixelated fader

Can I dictate a text and say for instance, oh that's nice so instead of, can I say something like. To end sentences where you normally say.


To make sure I never finish everything, I am now trynig out using the Godot Engine to make a game.

## Devlog

### Friday 6th of August 2021

#### 23:00 hrs

I have started to understand some things. So I can import mixamo characters, but I actually do not want those characters, I want something else. I want a really cool-looking character - in the future.

So, doing

OK, så man kan inte skriva på engelska med iPad:en så det blir fucking engelska nu.

Jag tänker pröva att köra 3d for the heck of it. Men då måste vi göra en superdupertajt POC för att se om det är något att ha, samt en plan för genomförande. Vi går baklänges och börjar med superenkel grafik - för det går alltid att lösa senare.

POC-todo:
* Spelar-entitet
* Fiende-entitet
* Målobjekt
* Fiendefödsloplatser
* Skjuta
* Skada

Om jag kan göra de där sakerna under helgen så tror jag vi kan testa att gå 3D generellt, för det är ju superkul, väl?

So a small To Do List for the 3D variant of the game is to be able to create. 

A player entity. 
Enemy entity. 
Objective. 
Enemy spawn points. 
Shooting mechanics. 
Damage to both player and enemy.
GamePad control support.

 
Can I make special characters by saying star? Horror flicks.




## Should we go 3D?

Creating sprites is a goddamned hassle. Buying them as well. But I can't really say that I have what it takes to do a 3d game either? Aaargh.

Check the tutorial for 3d, perhaps?


## The Backlog to End All Backlogs

Fun story, I have already made this game, once, in libGDX. But the tooling is non-existant so that felt like it was sort of grinding to a halt, a little bit, at least. I just want to make some games.

Anywas, I have a bunch of stuff that I already have, or am planning to have, in the "old" game. The old game that was supposed to be a clone of Turbo Raketti Ultra but immediately turned into my old classic "way too ambitious game for a first-timer".

Anyways, this list is obviously wrong. I need to pare it down, considerably.

We have player movement and sprites. So, what is absolutely necessary as the NEXT thing to do?

I want to make a nice map. I would really like that. Do I actually HAVE to make my own tiles? Perhaps I could just apply some filters to some tileset? Buy an isometric tileset from somewhere?

Or is it time to go "voxel" now? As an experiment? Look into it?

So, there was a lot going on in the old game.

### Game Setup Screen
* Character Selection

### Player
* Shoot
* Twin stick shooting
* Multiplayer
* Objectives
* Scoring
* Health 

### Enemies
* Behavior tree
* Melee attack
* Notice shots

### Towers 


### MVP

* Build Towers <- Doing
* Basic Sprite Editor <- done, kinda?
* IsoMetric Projection <- done!
* Towers <- Done
* Interactable Components in-the-game
* Player graphics made from components / parts etc.
* "Levels" or "Maps" in a more structured way
* Game Over Screen that does *anything* <- DONE!
* Start Screen that does *anything* <- done
* Scoring and Objectives <- done
* Game over man <-Doing
* Player death <- Done
* Fix enemy sensors / noticing <- advanced behaviors
* Fix enemy direction systems <- done?
* Vehicles <- nice to have
* Different weapons to shoot with
* Controller support <- Done
* Twin Stick shooting <- done
* Multiplayer <- done
* Player damage / Enemy attacks <- Done
* Objectives <- Done!
* Enemies <- Done
* Blood Splatter <- Done
* MiniMap <- Done


## Based on IsoMetric example from Godot Asset Store

# Original Readme:

# Isometric Game

This demo shows a traditional isometric view with depth sorting.

A character can move around the level and will also slide around objects,
as well as be occluded when standing in front or behind them.

Language: GDScript

Renderer: GLES 2

Check out this demo on the asset library: https://godotengine.org/asset-library/asset/112
## How does it work?

The level uses a [`TileMap`](https://docs.godotengine.org/en/latest/classes/class_tilemap.html#class-tilemap)
in which the tiles have different vertical offsets.
The walls, doors, and pillars each have
[`StaticBody2D`](https://docs.godotengine.org/en/latest/classes/class_staticbody2d.html)
and [`CollisionPolygon2D`](https://docs.godotengine.org/en/latest/classes/class_collisionpolygon2d.html)
at their base. The player also has a collider at its base,
which makes the player collide with the level.

## Screenshots

![Screenshot](screenshots/isometric.png)
<!--stackedit_data:
eyJoaXN0b3J5IjpbMTc1MzczMzA4MywtMTI0MjU4NzEzLC05Nz
EyODY1MTMsLTE0OTIxMzM2MDMsNDQ4ODcyMDU4LC0xMTUyNjU4
NjI2LC05MzYxNDM3MDEsLTE5MjA3ODIxMzYsMTAxNzEzNjQ0Mi
wtMjQ1MTc1Mzk1LDEyMjE3OTAxNTEsLTUyNTMwNDU4Niw2OTA0
NDI1MjMsLTkwNDgzODY1MSwtMTI0NTgyMzUsNjk5ODg1OTEyLD
E2NTE1NzUzODQsNzI1OTkwNTgwLC0xODY1Nzg0NjQ3LDEzOTA5
Nzg4XX0=
-->