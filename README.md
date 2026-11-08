# Roblox Script: Blox Fruit Adventure

Blox Fruit Adventure is a Roblox script that adds a server validated fruit ability for a Roblox Studio game you own or are authorized to edit. The Roblox script includes a FlameFruit Tool, a client activation script, a server side projectile, cooldown handling, range control, and area damage.

## Install

1. Open your Roblox Studio place.
2. In `StarterPack`, create a `Tool` named `FlameFruit`.
3. Set the Tool's `RequiresHandle` property to `false`.
4. Add `src/StarterPack/FlameFruit/FlameFruit.client.lua` as a `LocalScript` inside the `FlameFruit` Tool.
5. Add `src/ServerScriptService/FruitAbilityServer.server.lua` as a normal `Script` inside `ServerScriptService`.
6. The server script creates a `RemoteEvent` named `FruitAbilityEvent` inside `ReplicatedStorage` automatically if it does not already exist.
7. Start the game using Play in Roblox Studio.

## Use

1. Spawn into the game.
2. Equip the `FlameFruit` Tool from the StarterPack.
3. Click a location in the game world.
4. The ability fires a glowing flame projectile toward the clicked location.
5. The projectile travels up to 180 studs and damages nearby humanoids for 35 damage.
6. Wait four seconds before using the ability again.

To customize the ability, edit the values at the top of `FruitAbilityServer.server.lua`:

- `cooldownSeconds` controls the ability cooldown.
- `damage` controls the damage applied to nearby humanoids.
- `projectileSpeed` controls projectile movement speed.
- `projectileRadius` controls projectile size and damage radius.
- `maxRange` controls the projectile's travel distance.

Use this project only in a Roblox experience you own or have permission to edit.

---

More Roblox script projects by EnderDevelopment: https://github.com/EnderDevelopment

Project page: https://dash.enderdevelopment.com/community/d0a82db8-9e0e-4739-9c2a-0df540ce9300?utm_source=github&utm_medium=readme&utm_campaign=auto_publish&utm_content=d0a82db8-9e0e-4739-9c2a-0df540ce9300
