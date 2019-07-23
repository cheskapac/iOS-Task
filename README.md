# iOS-Task

Create app which consists of these screens:

## 1. Post list
 - Screen is shown after Splash screen
 - Screen shows **Posts**
 - Has pull to refresh
 - Displays loading indicator when **Posts** are being loaded

**Posts** and each User's data are stored in database, initially loaded from database and refresh from API.
Getting posts and user's data API calls are joined together using RX functions.

**Post Cell:**
 - User name, company name
 - Post title
 - Post body

**API**
 - Posts: https://jsonplaceholder.typicode.com/posts
 - User details: https://jsonplaceholder.typicode.com/users/{user_id}

 
 
## 2. Post detailed
 - Data is loaded from database
 - Screen has pull to refresh and updates data (user details and post details) from API, data is stored in database
 - Screen content is scrollable
 
**Screen components:**
 - User container
 - User photo on the left (round image) and user data to the right of the image
 
**User data:**
  - Name
  - Email - clickable, new email action with preffiled "to email"
  - Address - stree, suite, city, zipcode - clickable, opens Google maps app with coordinates
  - Phone - clickable, auto dials phone number
  - Company
  
**Post container**
 - Full post title
 - Full post body
 
**API**
 - Post detail: https://jsonplaceholder.typicode.com/posts/{post_id}
 - User photo url: https://source.unsplash.com/collection/542909/?sig={user_id}

 
**Note:** If error occurs (in main or detailed view) - error dialog is shown with general error message, two buttons (cancel - dismisses the dialog, retry - dismisses and retries failed action)


**Use as much as possible:**
 - Swift, RxSwift
 - MVVM pattern
 - RxAlamofire
 - Common Apple design
 - Constraints
 - CoreData or Realm
 - Dependency Injection
 - Coordinator approach
 


 

