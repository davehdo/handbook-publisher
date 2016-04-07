# Introduction
This is a heroku-ready app that allows creation and distribution of handbook content, for example creating a quick medical reference. Authors can create and nest folders and documents.

## Content organization 
These are rules of thumb for creating a useful bedside medical reference
* documents regarding emergent management should be at the root level (not nested) in a folder 
* minimize pages the user has to shuffle through (expect no more than 3 docs to be read on a routine basis), 
* name folders, documents, and sections with an "if" when possible (e.g. "if coagulopathic") to allow reader to skip sections 
* limit nesting depth to 1 or 2 folders, to minimize clicks 
* top level folders are "modules" - should be named after a presentation or a diagnosis that can be made quickly

# Dependencies

## Server side
* Rails 4.2.4
* Mongodb

## Client side
* Angular
* Jquery
* Coffee

## Styling
* Sass
* Bootstrap
* Fontawesome ```<i class="fa fa-camera-retro"></i>```


