# MusicPlayer

This project has been ported from Objective C to Swift, so all new development now happens here: github/wbraynen/SwiftMusicPlayer

Screenshots of what's implemented in this obj-c repo:

|MasterViewController|Detail, playing|Detail, paused|
|---|---|---|
|![image](https://cloud.githubusercontent.com/assets/4765449/11490289/74a0f258-9794-11e5-8046-0a111f5167b5.png)|![image](https://cloud.githubusercontent.com/assets/4765449/11545239/645ad1b4-9903-11e5-9f4b-bcb025805100.png)|![image](https://cloud.githubusercontent.com/assets/4765449/11544445/1a7168f0-98ff-11e5-99ec-e6521981dc28.png)|

The plan is to start with a mocked-up but functional player and then build on that.  For example, serve up hardcoded data, then add a CoreData store, then add http with my own node.js server (just like the one my lighthouse-api.org project uses); or just use RestKit instead of AFNetworking from the get go.
