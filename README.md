# Installation
- Simply run. No libraries used

# Approach to caching
- For the sake of brevity and time constraints, I kept it simple by using user defaults, as CoreData felt like overkill for such a simple list. 
- I also decided to keep it simple for the loading and caching. The app would attempt to load the cache and not automatically load from the API unless instructed to via buttons or even pull to refresh. 

# Limitations and tradeoffs
- Due to time limitations, unit tests could not be produced, but I have set up to make sure they can be done easily when the time comes
- Not using Core Data might be an issue later on, depending on how much we want to cache, but even then, I would suggest using Swiftdata to make it easier to develop.
- MVVM, though simple and easy to learn, opens us up to issues with testability, navigation and maybe even scalability. My preference would have been to do this in TCA due to how exhaustive testing can be, even with navigation. If that wasn't an option, we would recommend using clean architecture to avoid overloading the view model
