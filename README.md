# ShaguGhetto

A World of Warcraft: Vanilla and The Burning Crusade Addon that automatically invites everyone asking for a ghetto invite.

## Ghetto hearthing
> This trick involved creating a group for an easily accessible instance (such as the Stockades), zoning in, then passing lead to the other person and leaving the group, thus forcing the system to teleport you to your hearthstone point.

[WoWWiki](https://wowwiki.fandom.com/wiki/Hearthstone)

## Features
If someone asks for a ghetto, an invite is sent. If someone invites you to a group, the invite is declined and in return a group invite to that person is sent out. Whenever the group has more than 3 people, the addon automatically leaves. In case that the invite fails to server issues like "is already in group", a whisper is sent to the person, telling him to relog and whisper ghetto again. The addon monitors the WHISPER, SAY, YELL, GUILD and WORLD channels. Each invite is tracked per person and you see a counter on how many ghetto's the person received whenever an invite is sent. If the character is called "Ghettomann", a message is sent to either SAY or WORLD with the own name (see below)

## History
On Atlantiss Netherwing there was a player called "Critmann" who has been yelling his own name to the World channel whenever he killed a player of the opposite faction in [Stranglethorn Vale](https://classic.wowhead.com/stranglethorn-vale). Based on the service he provided to the horde, the idea of the Ghettomann was born to provide a more useful service. I used this addon to automatically invite everyone who asks for a "Ghetto" hearth in the Worldchat and yell "Ghettomann!" to the channel. Over time this addon became more and more fine tuned and now also handles group invites from other players. The addon provided roughly around 100-200 invites per day to my people.

## Development
The addon is considered as done and was nothing more than a small pet project. I will no longer use it since the policy change on Netherwing happened and I will not continue this project. It was already able handle everything I wanted it to do and I no longer play actively on any TBC realm. However, if you feel something is missing, please send a PR. But don't bother me to write new features for it. Also, this addon was never tested on vanilla.

## Installation (Vanilla)
1. Download **[Latest Version](https://github.com/shagu/ShaguGhetto/archive/master.zip)**
2. Unpack the Zip file
3. Rename the folder "ShaguGhetto-master" to "ShaguGhetto"
4. Copy "ShaguGhetto" into Wow-Directory\Interface\AddOns
5. Restart Wow

## Installation (The Burning Crusade)
1. Download **[Latest Version](https://github.com/shagu/ShaguGhetto/archive/master.zip)**
2. Unpack the Zip file
3. Rename the folder "ShaguGhetto-master" to "ShaguGhetto-tbc"
4. Copy "ShaguGhetto-tbc" into Wow-Directory\Interface\AddOns
5. Restart Wow
