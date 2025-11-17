# 🚌 Bus Route Creator — gg_busjob
A complete in-game route creator for FiveM, allowing staff members to create, edit, and export **bus routes** dynamically, fully compatible with **gg_busjob**.

Built by **Gordela**.

[![Vídeo de demonstração](https://i.imgur.com/GufQGHO.png)](https://youtu.be/22OWSxHRGX4)

## 📌 Table of Contents
- [Overview](#overview)
- [Features](#features)
- [Dependencies](#dependencies)
- [Installation](#installation)
- [Configuration](#configuration)
- [Commands](#commands)
- [How to Create Routes In-Game](#how-to-create-routes-in-game)
- [Route Export System](#route-export-system)
- [Project Structure](#project-structure)
- [Credits](#credits)

# Overview
This resource provides an intuitive way to create bus routes directly inside the game, without manually editing files.  
All stops, NPCs, rewards and route data are saved automatically on the server in an exportable file (`routescreated.lua`).

# Features
- Full in-game route builder  
- Add stops with E / finish with G  
- Up to 4 NPCs per stop  
- Automatic saving  
- Multi-language  
- ox_lib integration  
- Clean export formatting  

# Dependencies
- ox_lib (required)

# Installation
Place the resource in your server:
```
resources/[local]/bus_route_creator
```
Add to server.cfg:
```
ensure bus_route_creator
```

# Configuration
In `config.lua`:
```lua
Config.Locale = 'en'
```

# Commands
**/createroutes** – Opens the main menu to create/edit routes.

# How to Create Routes In-Game
1. Use `/createroutes`
2. Choose "Create New Route"
3. Fill route information
4. Add stops with **E**, finish with **G**
5. Place up to 4 NPCs per stop

# Route Export System
Routes are exported to:
```
routescreated.lua
```

# Project Structure
- fxmanifest.lua  
- config.lua  
- client/client.lua  
- server/server.lua  
- locales/*  
- routescreated.lua  

# Credits
Developed by Gordela / New Age Studios
