# FAQ

TODO: insert TOC here


## Who is this for?

Me. I'm a Linux systems administrator and engineer.


## What is this about?

This is a repository of semi-structured notes I wrote while configuring my Steam
Deck gaming console.


## Why is it written this way?

After reading blog posts from Dan Luu, listening to the ReWork podcast and some
others I thought it was an idea to try out. So it's me talking to myself
naively about technology in public without trying to create a stage. Just to
get better at writing and organizing. I wrote some things on StackExchange some
time ago which would also benefit from improving my writing.

It's a repository for things I don't want to keep in my head or in a todo list.


## Should I reduce the EXT4 reserved blocks count on Steam Deck?

No. The reserved blocks count, which is typically set to 5%, is set to 0 on
Steam Deck.

**Note:** This is an interesting experiment from my point of few because some
people advised against my advice to reduce from 5% to 0.5% or lower with
`tune2fs`. I trust Valve's developers on this one, but I should research where
the 5% default originated and what purpose it serves. Many customers and admins
are not aware of this.


## Is there any benefit in researching to choose different filesystems?

Probably not. Someone wrote a script to convert the home partition to Btrfs, but
we will have to see how that plays out during future platform upgrades. For the
default Valve should have a plan to not brick their customers systems and make
them start from scratch. That lost time and money may outweigh potential
performance improvements and storage savings. Additional microSD cards are on
sale from time to time. That's good enough for me. Want to go beyond that?
Setting up USB-C NVME or HDD drives should be possible with reasonable effort.

You can do encryption with EXT4 as far as I know. XFS is default for RHEL, but
we are not running a RHEL server here. Recent Fedora chose to use Btrfs and I
think ChomeOS also makes use of it somewhere. Definitely not trying out ZFS on
Steam Deck, altough I like it.


## Is there any benefit on replacing the internal SSD?

I have the 512 GB model. While you could do it, you would need to find an M.2
2242 drive with better perfromance in the same power and temperature budget. I
wish it was easier, but finding such drives is not easy for me at the moment.
I'm still looking for a replacement of my Toshiba RC-100 drive in a different
device and I can't find one. Single sided or double sided? B-key, M-key or
B&M-Key? Not with investigating this at the moment.


## How to reduce installation size of games?

Example: Forza Horizon 5 is over 100GB in size.

There is no standardized way at the moment as it seems. Some users suggested
abiguously deleting files they think are safe to delete, like very high
resolution assets, but this is not safe and steam will report that the game
content is inconsistent when performing a check and starting downloads. A bad
idea that multiplies and gets worse when you have a few more titles which
frequently receive content updates.

Games like Fortnite on the other hand---when I run it on Windows 2 GO on the
Steam Deck---provide an option to remove or not download high resolution content
which optimizes for smaller or low powered devices. But Microsoft and other
publishers seem to assume that a Steam client is a PC and if it downloads some
title it must be a high performance workstation. Steam Deck is somewhere in
between a Nintendo Switch and an Xbox Series S and I'm sure many who claim
themselves to be gamers have hardware with comparable perfomance and should not
have to shell out money to download and store content they don't need right now.
I have probably used to much Linux pacakge management and gaming consoles to
criticize this here. We will see. Microsoft claim that their Smart Delivery can
do wonderful things, but a video by MVG gives me the impression that
optimization was an after thought and it's mostly about DRM.

**Note:** Needs more research, I'm probably just using inappropriate search
terms and filters.


## Can I run monitoring?

Sounds like an interesting idea from an infrastructure admin point of view. Not
sure about that, may be we can install Netdata in some way and gain some
insights through metrics. Steam Deck has a performance overlay which does what
gaming journaslits expect though.


## Can I run games bought from the Origin or GOG store on Steam Deck?

Yes.

TODO: See steamos#heroic


## Can I run games bought from the Nintendo store?

No.

Read carefully here. I own a Nintendo Switch, I bought some games there, some of
them are not Nintendo exclusives while others are free to play. It would have
been nice to run some of them legally with minimal effort, like for example
Fortnite. It is not possible or reasonable for me and I accept that.


## Can I modify the controller inputs?

Yes, in desktop mode open the steam client, select Steam from the menu and go to
Controller. You can change the layout, button mappings and all other possible
attributes there.

I change to the default layout, which was not detault on SteamOS, for which I
swapped PGUP and PGDN, set mouse acceleration on the trackpad to high und
reduced haptic feedback.


## My games look like Pixel Art, but not in desktop mode

You have enabled half rate shading in the power menu, disabled it.
