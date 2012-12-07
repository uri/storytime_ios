StoryTime iOS
=============

This is the client for `http://storytimeuri.herokuapp.com/`

To run and open the project you **must** open the workspace *not* the project file.

To change the app to use localhost instead of the live server change

    #define WEBSITE @"http://storytimeuri.herokuapp.com/"

to

    #define WEBSITE @"http://localhost:3000/"

in `storytime_ios-Prefix.pch`