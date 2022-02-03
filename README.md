# MuseumAPI
This is Sample code for demanstrating the MVVM architecture with SwiftUI, along with some new features provided by the Apple.
For network API, I Used with Museum public APIs. 

# User Custom SearchBar
In this project I have created the Custom SearchBarView, instead of using the Default SearchBar which provided by Apple.

We offer user to use `UISearchbarController`, once is active and start search with any text show the result in the new list, once it has been dismissed then all the search result list view removed and back to previous screen. But here we don’t have this kind of requirement we have static List of item with the search, and the SearchBar is always there for the users.

# Debounce
We are using the Debounce for stopping/halting send the multiple network call request while the user is typing every single character.

# Netwokr Call
I have used the [Alamofire](https://github.com/Alamofire/Alamofire) API which very easy to use.

# Pull to refresh
Added the Refresh list to both the screen so that user can refreshes the content of the screen. To achieve this I am using the `.refreshable` modifier which is available from iOS15.0+

# Handle URL value with URLQueryAllowed
In this we are calling the API with the GET method and the parameter may have the either SPACE or any special character, which not supported by the URL. Even for the image URL we applied this case.

# Custom Image View 
[In this project we have two types of view for showing the Image](https://github.com/SumeetMourya/MuseumAPI/blob/main/MuseumAPI/MuseumAPI/Costom_Controls/ShowImage.swift) 
- [AsyncImage](https://developer.apple.com/documentation/swiftui/asyncimage): This is provided by the Apple and which is available from iOS15.0+
  - **Advantage**: It is provided by Apple and can be use any of the animation we would like to introduce with image.
  - **Disadvantage**: When we use within the List Item cell, then it will go to reload the image, it's not cache the Image. 
- [SDWebImageSwiftUI](https://github.com/SDWebImage/SDWebImageSwiftUI): This is third API, for getting the network images, with minimum code
  - **Advantage**: It is supportive to the image caching and neither reloading the Image when every time cell appears from the same image nor when change the orientation of the device.
  - **Disadvantage**: It does not support the animation which is provided by Apple in SwiftUI. We need any type of animation, then we need  write the code according to that.

# Haptic notification
Notifying user when the user sends a request for the Pull to Refresh successfully.


