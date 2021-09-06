# suburban-commando

## Back 2 Basics

I have, predictably and finally, come to the conclusion that I need to go back to basics. What does that mean? It means that my knowledge of the Godot Engine and 3D game programming is to limited to work on importing advanced models into the game. That takes to much time and effort, time and effort that should and must be spent on learning "the ropes". The ropes in this case is concepts such as local transforms, rotating objects and not the camera, and so forth. The TODO-list will still be basically the same, we will just start "anew".

## Devlog Sunday 5th of september 2021

So, I decided to experiment with a different implementation of behavior trees for godot. They guy that made this one seems more competent... :D

## Devlog Sunday 29th of August


## Devlog Saturday 28th of August
So, we are almost back where we started - or rather, where we left off, when we switched to Godot. Or rather, that's not actually true. We have a bunch of features that are not yet implemented, for this one.
So, we should list these features and write a small note regarding what they mean.

## Things that need to be done

The thing in cursive is what I am working on right now.

- [ ] *Enemy AI and attacks*
- [ ] Objectives
- [ ] Player Health and Death
- [ ] Multiplayer
- [ ] Controller Support
- [ ] HUD
- [ ] Splash Screen
- [ ] Blood Splatter
- [ ] Visual Stylings
- [x] Towers
- [x] Level 2
- [x] Player Movement
- [x] Enemy Entity 1
- [x] Shooting
- [x] Level 1
- [x] *Player 0*
- [x] Player Entity 1

### Enemy AI and Attacks
We need a better AI. Or rather an AI that seems better. The AI should work by doing very small actions in sequence. So, we could have something like, if the player character is in the sphere of detection, the enemy should stop what it is doing and turn towards the player.

Or, what is it that we want to do? We want the enemy AI to be a *threat*, a threat that searches for you. So if the player is in the sphere of detection and *moves* - that should indicate to the enemy that there is something to investigate. Like a sneak-thing. If the player shoots, everyone in some circle should be able to hear it and go to examine it. 

#### Mechanics
So, the enemy has a *detector* that keeps track of players in the proximity. However, a player being detected by the detector doesn't actually mean that the enemy has detected the player, just that it *could*. 

Fudge the mechanics. 
#### Behavior Tree
We could surely use a nice syntax for writing behavior trees, my man. So, if we think in very, very general terms, and use groups, we can get a nice tree going. So what do the enemies WANT to do?

This is a really cool question, because I just realized I want them to do stuff when the players aren't around, as well. They should be looking for food, breaking shit, stuff like that. 

I want them to naturally **flock**, so that if they are not doing anything top priority (like attacking a player), they will check their surroundings to see if there are any other enemies around. This obviously only goes for our zombie enemies. T

### HUD
Simply an overlay or something like that, displaying ammo, health, score, objectives and such.

### Towers One
#### Mechanics
Towers aren't just towers, it's about *family* as well. No. I mean, it's a whole package, it's building, its types of towers, it's the tower shooting and so on. Well, So far, I have managed to create a tower model, placing it, now it needs some AI and some shooting mechanics. We'll start simple with a kind of not very good tower that shots every now and then. In the end, I would also *love* to have **funny** towers, shooting poop grenades and whatnot.

Tower shooting thingie - the tower should have a raycast built in from the tower weapon head. If an enemy body is inside a sensor, the tower should slowly lerp its tower head rotation towards that enemy. When the angle is within some kind of margin the tower should open fire and the raycasting should be at least slightly random, I think. Or perhaps we should do the weapon firing as an AREA with a change of hitting depending on distance? There are so many options here, all worthy of exploration.
 
- [x] Visual stuff on towers, like muzzle flash
- [x] Create a tower model
- [x] Player should be able to place the tower on the map
- [x] Tower should be able to target enemies
- [x] Tower should be able to fire at enemies 

### Objectives
Something on the map that the player needs to move to in order for the game to continue to the next level.
#### Mechanics
Objectives can actually be expanded upon to be something more than simple *waypoints* for the player to visit, now that we use a more advanced game engine. These objectives can represent special pickups needed to progress through the game, like key-cards or whatnot. They can be triggers that interactively open some gate in some other part of the map and so forth.

### Splash screen
Player select, character select.

### Blood splatter? 
This is part of the "visual stylings" concept - when shooting, we need FX for the hits and such.

### Player health and death
So, we have health for enemies, when enemies can attack, we shall have damage, health and death here. This also means an implementation for "lives" for the players as well, of course. Or perhaps a resurrection mechanic?

### Enemies hearing players shooting
This means handling "interrupts" from sensors and such, much like what we had. 

## Level 2
But what should be the point of level 2?

I know! I will create a pre-fab house with a yard. Perhaps there will be a fence, who knows? The point being that I will import resources and add and combine them into a house with a yard. And, even fucking crazier, I will create yards that can have... *different* houses on them. That's gonna take the cake. This has now been implemented. Very cool.

## Player movement
So what is really up with the player movement thing? Well, here's the deal: it's not working. It feels like it *did work* and for some reason has *stopped working*. This is the bane of software development and why you need good git discipline. Everything line of code you write or test must be in isolation of any previous working code you have written. Otherwise you end up with large changesets that yes, introduce new working features (like the AI stuff) but break something else (like player movement) and you no longer have any clue what does what.
In my case it has to do with a lot of stuff with collisions and movement I made at the same time, putting a spanner in my works. But fear not, I have several strategies to fix this. Or two, I have two strategies, plus an idea.

### Solution found
So, using the strategies below I managed to fix it proper, I think. So there were several problems related to all of this, like the rotation of the character movement being off (and I realize I might have to fix it later, to make speeds correct depending on direction, more on that later) and so on. Who cares. No it should be OK. Anyway, the problem was probably related to collisions and collision layers in the code. Now we can move on, perhaps.

### Rollback to working state
Here's why you need Git discipline. If there existed a commit in my Git history that said "Player Movement DONE" I could simply checkout that commit and compare it to the state the code is in now and find important clues to why it used to work but doesn't anymore. However, I fear that this committ doesn't exist. We'll see.

### Isolate feature
If the above strategy doesn't get us anywhere, I will simply create a new Scene to troubleshoot all of this. It will simply contain the player, the camera and some ground. What I do need, however, is some kind of structure on the floor to see if the player is actually moving around a bit. 

### Rotate Schmotate
I just realized I rotate the direction of the player, then do move and slide, perhaps we could work that into things, somehow? It appears, now, that the rotation interferes with the movement and stuff, which I was pretty certain was working. But we need to look into this. What I am getting at is rotating movement 45 degrees in the other direction to get into working order...

## Enemy Entity 1
### Mechanics
Here we go with the AI again, don't we? The enemy has to be able to walk around, look for stuff, react to things - and make decisions.
So, some more notes on this... there are Behavior Tree implementations out there and they're a bit annoying, to say the very least.


## Shooting
### Mechanics
So, for now the weapon is quite tightly coupled to the player, but it is there. There is a poor effect when hitting something, but it is there. The enemy that I so happened to create is also there and can not only take damage, but also die. There is a signal for death and taking damage, meaning that the enemy could in fact blink or something when taking a hit. Very cool.


## Level 1
### Mechanics
After many trials and tribulations, I stand here again, ready to make a level of some sorts. I will try to accomplish this in the simplest way possible. It will most likely be combined with shooting and enemies, because that is how I roll.

## Player 0
### Mechanics
The player should be able to walk around - and how do I want to do that? Do I want it to be nsew-oriented, or more like propulsion, rotation, direction, what? I think cognitively it is easier to do it nsew-oriented, it is the way both south park and helldivers work with their controls. 

So, what we have now is an ugly model doing ugly model things - but that is friggin' great. So great! 

## Enemy Entity 1 <- doing now
### Mechanics
Update: I will not use Mixamo for the enemy character, as of now.

What is the mechanics for this first implementation of enemies in the game? Well, they should be simple, not complicated at all. I would like the enemy to be able to idle, walk, and do some kind of simple attack. I decided to use Mixamo again, but I would like to find some kind of "simpler" character somewhere on the Interwebs to make the next task, having a cool visual style of the game, work. I notice that my work here, compared to the work I did on the other game, is less straight-forward. This is most likely due to me not being comfortable with what I am doing, not really having a *feel* for how the engine actually works. This is fine. So, anyways, I want to have behavior trees as well, so we should look into the absolutely simplest way to get that done in the game.

The enemy should basically only want to do the simplest possible things right now: walk around, searching for player to attack. So, the next step is to import the downloaded asset into Godot and make stuff happen from there. 

- [ ] Create Model
- [ ] Create ontrols
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
eyJoaXN0b3J5IjpbODQyNjM5NTUxLC0xMTUxNDU4NTEyLDE4MT
QzODc1MCwtMTA1NjQzNjUzNCwtMjk5MDAyMjgwLC0xMzQ2NTc5
MTM5LC02NDU4OTAwNjksLTE2NjcxOTY0ODksLTIwMDUwNjM4Mz
UsMTQwOTI5NTQ1MiwzNzI4MTIwOCwxMDcxNjc4OTgyLC0yMTQz
NjUxNzIyLC0xMTY3NTIyNzYwLDEwMjY5NTExOCw4MDI4MjI5Mj
EsLTIxMzM3MDk2NTgsNjA2MjU2MDIwLC02MTk2Mjk2MzksMTkz
NTg1MTg3MV19
-->