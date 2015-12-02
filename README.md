# MusicPlayer

This is an iPhone app.  It is a specialized music player for experiencing the albums posted at [pianowill.com](pianowill.com).  The idea is that (a) this is just a pet hobby project and (b) because it's a specialized player, it can be more user friendly because it doesn't have to do everything -- just a few things well and intuitively :)

The plan is to start with a mocked-up but functional player and then build on that.  For example, serve up hardcoded data, then add a CoreData store, then add http with my own node.js server (just like the one my lighthouse-api.org project uses); or just use RestKit instead of AFNetworking from the get go.

Why not in Swift, you ask?  Well, wanted to code some stuff for fun in obj-c, but of course Swift is the man and I do plan to port the player over to Swift once I knock out all the basic functionality in obj-c.

Screenshots of what I have implemented so far:

|MasterViewController|Detail, paused|Detail, playing|On last track|
|---|---|---|---|
|![image](https://cloud.githubusercontent.com/assets/4765449/11490289/74a0f258-9794-11e5-8046-0a111f5167b5.png)|![image](https://cloud.githubusercontent.com/assets/4765449/11524486/6fb95d80-9888-11e5-9233-ca3659b40c08.png)|![image](https://cloud.githubusercontent.com/assets/4765449/11524487/6fba72a6-9888-11e5-8f20-43e5d9154aff.png)|![image](https://cloud.githubusercontent.com/assets/4765449/11524488/6fbb4a46-9888-11e5-88ae-c72bf4f1c00b.png)|
