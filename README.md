# Mid-Program Project - README

===================================================================

# STREAMUS

Jorge Alejandre, Stephon Fonrose, Rodrigo Lapenne, Curtis Lee

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
Allows the user to choose their favorite genres and artists and then suggests them to a group to join. User joins groups and users can suggest new music and group can vote up or vote down music to add to the shared playlists.

### App Evaluation
- **Category:** Social Networking / Music
- **Mobile:** Would mainly be made to work for mobile only. It could be available on a computer but we imagine that it would mainly be used for mobile. The idea is to have it be an easily accessible app for people and easy to use.
- **Story:** Takes users favorite genres and artists and suggests stream rooms for the user. Once in a group, other members can vote on music and create a joint playlist for all to listen to and enjoy. Made to discover new music as well.
- **Market:** This app is made for all music lovers who are looking for new music or people who enjoy the same music taste as them. Puts you into groups with similar music tastes so there is reason to have to listen to music you do not enjoy. 
- **Habit:** User can use it as they please. If they just want to listen to music 24/7 then it would be perfect for them. They can listen to new music and never get tired of the same old songs.
- **Scope:** We would love to have this app have a way for the users to chat and suggest concerts and get involved in the music community.

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* User logs in or registers and start to create their profile
* User chooses their favorite genres and then artists
* User chooses groups to join and share music with
* User can edit their own profile page

**Optional Nice-to-have Stories**

* [fill in your required user stories here]
* ...

### 2. Screen Archetypes

* Login Screeen
* Register - Users set up username and password or login into account
    * Preferences Screen - When registering the user will be asked for a set up preferences including genre, artists, with other characteristics such as sub genre being optional.
* Home Screen
    * List the different stream room options that the user has
        * Your Streamrooms
            * Rooms that you actively particpate in
        * Friends Streamrooms 
            * Rooms that your friends are active in
        * Public Streamrooms 
            *  Rooms of anonymous people that align to your preferences 
* My Music 
    * Music that you have approved from all your playlists. Includes shared playlists.
* Settings
* Profile
    * Allow users to add an avatar, and a status. Also the way to change preferences.

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Home Screen
* My Music
* Settings
* Profile
**Flow Navigation** (Screen to Screen)
* Log in -> Attempts to login based off user information. Prompts the user to create an account if unable to login.
* Home Screen -> 
* Settings ->
* Profile -> Opens the users avatar and 

## Wireframes

<img src="https://i.imgur.com/kK9wVCO.jpg" width=600>

### [BONUS] Digital Wireframes & Mockups

### [BONUS] Interactive Prototype

## Schema 
### Models
#### Stream Rooms
| Property Name   | Type             | Description                                         |
|-----------------|------------------|-----------------------------------------------------|
| genres          | Array of Genres  | contains the main genres feature in stream          |
| artists         | Array of Artists | contains artists that serve as base for stream      |
| dislikedGenres  | Array of Genres  | genres that users indicated don't belong in stream  |
| dislikedArtists | Array of Artists | artists that users indicated don't belong in stream |
| id              | Integer          | unique identifier for stream                        |
| privacy         | String           | indicated whether stream in public or private       |
| users           | Array of Users   | users that can contribute to stream                 |

#### User
| Property Name | Type             | Description                             |
|---------------|------------------|-----------------------------------------|
| id            | Integer          | unique identifier for user              |
| username      | String           | unique login username                   |
| displayName   | String           | name that is displayed to others in app |
| profilePic    | File             | profile picture for user                |
| favGenres     | Array of Genres  | genres that user indicated they liked   |
| favArtists    | Array of Artists | artists that user indicated they liked  |
| friends       | Array of Users   | list of in-app friends                  |
### Networking

- Home Feed Screen
    - (Read/Get) Store and display the users rooms
        ```swift
        let query = PFQuery(className:"Rooms")
        query.whereKey("member", equalTo: currentUser)
        query.order(byDescending: "createdAt")
        query.findObjectsInBackground { (rooms: [PFObject]?, error: Error?) in
        if let error = error { 
            print(error.localizedDescription)
        } else if let rooms = rooms {
            print("Retrieved \(rooms.count) user rooms.")
            }
        }
         ```
    - (Delete) Remove user from a room
        ```swift
        query.remove(forKey: "playerName")
        query.saveInBackground()
         ```
- Profile screen
    - (Read/Get) Display current user object
         ```swift
        let query = PFQuery(className:"users")
        query.getObjectInBackground(withId:"userName") {
        (currentUser: PFObject?, error: Error?) in
        if let error = error {
        print(error.localizedDescription)
        } else {
        //The object has been retrieved
        print(currentUser)
            }
        }
        ```
    - (Update) Add user profile image 
        ```swift
        let imageUrl = URL(string: (user["profile_image_url_https"] as? String)!)
        let data = try? Data(contentsOf: imageUrl!)
        
        if let imageData = data{
            cell.profileImageView.image = UIImage(data: imageData)
        }
        ```
- [Create basic snippets for each Parse network request]
- [OPTIONAL: List endpoints if using existing API such as Yelp]

