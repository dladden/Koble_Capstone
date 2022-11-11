
**Kobble**** : iOS Dating Application**


**Summary**

In Norwegian, "kobble" means to connect from the noun "koble". The idea of the iOS-based application name comes from the desire to find a name with a meaning which describes the concept of a product that embodies the purpose of connecting the users. Yet foremost, through the inspiration of a dear friend of mine. The goal of Kobble is to connect users based on one-word interests. However, to retain the standard features of modern applications. The flexibility drives the prototype as a cloud-based application and a natively driven prototype. With the use of Xcode IDE, Firebase Console, and dependency manager, a minimum viable product is developed which the intensions of a fully driven application. This makes a robust prototype with the full objective of creating a full-fledged product. Due to possible trademark mishaps, as the name operantly is taken by a few applications, the modified interest-based app is called Kobble.

**Kobble**** : iOS Dating Application**

**I. Project Introduction**

_a. Software Process: Incremental Development_

The development of Kobble is based on incremental development. This development is implemented to prioritize certain features over others. As a part of small relaces, the process of development includes pushing new updates through GitHub. The fundamental features for a user-friendly application extend to user authentication, user password reset, user password security, user email update, username update, autologin in, and user information update. All these features are found in Kobble. However, there are other essential features that are needed to up to the specification of a standard application.

_b. Essential Features_

Kobbles essential features include the user's ability to sign in and authenticate the user's email. For security reasons, these features are essential. Additionally, the user's ability to provide minim information like date of birth and city location is important. Date of birth is essential information as it creates a safe environment for all of the users. Likewise, location is another important aspect, even if the user's goal is to meet new people remotely. Location can facilitate filtering for users who need to make connections based on locality. As the core feature is user interest, provided by the user is used to make connections with the user who have the same interests and want to make a conversation based on those interests.

_c. Setting up the Dependencies_

CocoaPods is a dependency manager for Swift and Objective-c [(1)](#ref1). It allows the developer or a team of developers to create library dependencies for a project. As well as enable the developers to specify the versions which are needed for the development and configurations of a project. Kobble utilizes a few essential libraries and SDKs [(2)](#ref2). The most crucial library is Firebase SDK which is used as the backend portion of the application. Koble utilizes Core, Authentication, Firestore, Analytics, and Messaging Packages for development. Kobble also uses the Progress Heads Up Display library, which is used to create UI features for users' ability to see progress and display errors [(3)](#ref3). Kobble also uses a Shuffle-iOS package for creating the platform for matching with users through the utilization of cards [(4)](#ref4). Kobble utilizes a Gallery View Library, which allows the user to use a camera directly on the application and import images from the library [(5)](#ref5). In order for the user to view their multiple interest images, SKP-Photo-Browser is used [(6)](#ref6). This allows the user to view multiple images on their page. However, this feature is not yet implemented. Additionally, Kobble imports a Message-Kit which would be used to create an implementation of messaging between users; as a consequence of limited time, it is another feature that is not yet implanted. As an incrementally delivered product, Kobble is easily accessible on Github, and to begin running Kobble on your Xcode, the "pod install" terminal command needs to be run. This will install the dependency, and Kobble will be ready to be built and ran in the simulator [(7)](#ref7).

_d. UI Asset Building_

All of the assets used for Kobble are custom designed, to makes sure there is a uniformity in a design which makes the user interaction more fluent and familiar. Kobble retains a certain stylist choice based on one color scheme and a set of similarly baring assets which are designed to look simple and functional.

![](RackMultipart20221111-1-z54yfk_html_5dfdd5d03f8cee22.png)

Assets are designed using illustrator and all assets used in Kobble are svgs. Assets are then loaded into XCode assets section and retrieved in code or in Story Board without reference.

**Main Story Board Development 1**

![](RackMultipart20221111-1-z54yfk_html_46befc478a5aa6fb.png)

Kobble permanently enabled light mode. This ensures that the UI of the application remains constant throughout application use. The Information Property List allows the developer to set certain states for an application that becomes permanent on all devices. This is how Kobble permanently sets rules for the application. The development of the Signin-View-Controller on the left and the Signup-View-Controller on the right is done by laying out labels, text fields, UI buttons, and Image-View, which are then set by constraints that to a resemblance to CSS.

![](RackMultipart20221111-1-z54yfk_html_a97c35389c413938.png)

_e. Creating the Sign in and Sign-up UI view_

Signin-View-Controller and Signup-View-Controller have embedded UI text fields from the Story Board development and are accessible in the classes. This makes the logic of the classes very accessible and easy to implement. These classes house simple logic for user front-end interactions. As in Signup-View-Controller, for example, confirming that two passwords match before allowing to register the user in the Register-Button-Pressed method.

_f. Firebase First User Authentication Intro_

![](RackMultipart20221111-1-z54yfk_html_dba7b5a136344964.png) ![](RackMultipart20221111-1-z54yfk_html_9ac7322cfcda14d3.png)

The Firebase-User class is an important class in Kobble application that models a user object. It creates connections to the Firebase through the use of Dictionary. The Signin-Controller-View and Signup-Controller-View provided some limited crucial data to the Firebase-User class to store it locally while the user is operating the application. Signin-Controller-View houses logic for the user to sign back in and also a class to the signup through UI button for registration. SignupController house's ability to call on the FirebaseUser Object to instantiate a user, save it locally using Dictionary, which assigns keys to data instead of saving raw data, which could lead to the compromised information. Once the user is authenticated using email, then only the local data is pushed to the database stored using Firebase Storage. This ensures that the database is not used when the user is authenticated through their email. Firebase also contains logic to send the authentication email through the Auth class in firebase

_g. Firebase Authentication Testing and User Limitations_

When the user sets up the account he must fill-in certain fields like username, email, date of birth, their gender, city and lastly a matching password. After this the user receives a verification email into the email address which was used to create the account. User then emidelty has the abluty ti change the password in the Sign in section of the application.

![](RackMultipart20221111-1-z54yfk_html_f8b6de8d42ee8fd7.png)

_h. Email Verification Send-Out_

Fire base provides a functionality of sending the email out with the Auth-Data method. In the firebase class a function Register-User-With sends a verification to the user, and is called in registration in the Signup-Controller-View

_i. Firebase-User, Firebase-Listener and Extensions_

When setting up Firebase iOS project, the Firebase provides the developer with Google-Service-Info file in console which is designed specify for iOS application. This identifies your project with the Firebase database.

These classes are very crucial and have an important function in the application. Firebase is user object, Firebase-Listener is the data processing listener and Extension file houses extension needed to perform like visual changes.

![](RackMultipart20221111-1-z54yfk_html_53143a2228f036b7.png)

![](RackMultipart20221111-1-z54yfk_html_61ad45138a95226d.png)

_j. Initialization of User Object (Constructor)_

The user has many variables which are used in the application. Object id is assigned to the user when the user is registered and it does not change ever. Besides username and email, some other variables are essential within the application. Profile link variable, which is used for uploading and downloading the profile image. The interest is a variable string that can be edited by the user. Current job, this is a type of section describing your current field of work, which is an optional portion to be provided by the user. Interested-In portion, which is who the user is interested in. About the interests, this section is added for users to talk more about their interests in more detail. Liked id array is for the array of images, and image links is for upload and download of multiple images.

To initialize these variables, an initializer is used, which initializes and sets all the values before any use. Swift has a feature that allows the use of optionals. Optionals is a very powerful tool that allows you to use optional values and are set with a trilling question mark. Optionals can be used when a value is absent. This means that there either can be a value, and you can unwrap the optional, or there is no value at all. In Swift code can be also forced unwrapped, which is only safe if you are absolutely sure that the value is not zero. This feature must be used carefully because if force unwrapping is implemented on a variable which is zero, the application will crash.

![](RackMultipart20221111-1-z54yfk_html_5ab168db66550a33.png)

_k. Registering User_

The initial step in Kobble is to prevent the user from utilizing the database storage when they are in the progress of authenticating themselves. This is to ensure that the user is able to access his email. Only and only if they are able to authenticate the UID data, password and email should be stored.

To-do this Function Save-User-Loc saves users locally utilizing Dictionary. Dictionary is Swift data storage with relational keys. Adding the keys into a separate Constants file class to make it available for the application globally. This, in turn, allows to create a "stand by period" for verification. Once verification is completed and the user goes to login, certain checks are made. Check one: is the user now available in the Firebase authentication. Check two: is the email verified. Check three: is the user already in the database, meaning they already signed up before. When these checks are met, the user is saved into the database since it is their first time signing up using the locally saved information. The keys have to be unique, and so in the Constants, the keys are declared with UID.

_l. Dictionary & First Localized User_

Bellow are images of the Dictionary and the first localized user stored on Kobble application

![](RackMultipart20221111-1-z54yfk_html_27c2877da247a3e1.png)

![](RackMultipart20221111-1-z54yfk_html_80e03e47e4f10a23.png)

_m. First User Signup Example_

Below is an example of first user which is verified and stored locally on the Kobble application.

![](RackMultipart20221111-1-z54yfk_html_bdc6b41b1e61742.png)

_n. Firebase Database_

Firebase provides a root folder which is used by the folder hagiarchy system. The folder contains collections that are used to store the users from the app in the database. There are a few classes and functions provided by Firebase SDK for functions in this application for connection, fetching, updating, and saving data. Firebase Collection Reference function, which gives the application root directory access to the folder and the collection. Firebase Listener Class utilizes an initializer that takes the snapshots from Firebase and returns a new user object.

![](RackMultipart20221111-1-z54yfk_html_2a92ee58f5618515.png)

The image above is the dictionary initializer for the Firebase Listener. To save a user to Firebase, Kobble performs certain checks. First, it checks to see if the user is already in the database. Next, it tests to see if the user is in the system, and what is the latest entry needs to be pulled to the localized user. Finally, it checks if the user is not in the database, and initiates the creation of a snapshot entry for a new user. To do this application gets access to the Documents with the Firebase Reference function in Firebase Listener. Then we access the collection.

![](RackMultipart20221111-1-z54yfk_html_2bc7efdb60361ff1.png)

In the image above is the Document and a first collection was instantiated named User, with the long UID string. All users are stored in the collection. In this instance, a test user is created with a UID. Finally, note the "koble-5af3f"; this is a unique Firebase project identifier that is given to your project by Firebase.

_o. Password Reset_

Image below show portion of the password reset class function.

![](RackMultipart20221111-1-z54yfk_html_601a2f62f7a0042e.png)

_p. Auto Login_

Auto login is function which checks if the user is in the data base and if keeps user logged in.

![](RackMultipart20221111-1-z54yfk_html_b38a13c85816ca60.png)

**Final State for Sign-in & Sign-up**

![](RackMultipart20221111-1-z54yfk_html_25c6ed72273f8b5d.png) ![](RackMultipart20221111-1-z54yfk_html_5d9898fc608691fa.png)

**II. Profile View and Data Storage**

![](RackMultipart20221111-1-z54yfk_html_5b513923f75b085b.png)

_a. Main Story Board Development 2_

Profile once again is created using the main storyboard and the View-Controllers. However, this time with the navigation controller, which allows creating a native bezel called header to add functionally for toggling between the Controller Views. In the image above, Kobble has three views, but there will be four. Kobble Views are set to be: Profile, Home, Messaging, and Matches. The Profile view is the scope of this report, created in Profile-Table-Controller. Profile view houses additional information that the user can edit. For this, an edit functionality was added, which blocks all inputs until the user clicks on the edit button. The information inputted or edited by the user is once again stored first locally until the user clicks the edit button again at which point data is not saved or save button. The data is sent to Firebase if user clicks save. In the extension file certain calculations are now made, one of which is age, it is calculated based on the date information collected and stored in the Firebase from the user in the signup. The age is then included in the Load-User-Info function using formatting from the interval function in Extensions. This function returns an Integer by subtracting the current date from the date input by the user. To get the time from the Calendar Ordinality Method provided by Swift is used. The two values are simply subtracted.

_b. Profile Editing Mode_

Below is an image of the editing mode and the profile layout.

![](RackMultipart20221111-1-z54yfk_html_1fa830a7bb0e7afd.png)

_c. Saving User Data_

An important function is Edit-User-Data in the Profile-View-Table file, which takes in the values and stores them locally into the Firebase-User with Save-User-Loc function, then it uses the Dictionary to save the information locally. To save the user to the Firebase, a function Save-User-To-Firestone is utilized. Function Load-User-Info, which is used to load the user information from the Current-User, uploads the data to the profile view for the user. Additionally, in order to update the status of edits for the user and not to upload a new image every time the user makes new update, a simple if else statement written.

![](RackMultipart20221111-1-z54yfk_html_724dc8243ce9f041.png)

As seen in the image above, the Edit-User-Data function is utilizing the functions which disable the editing mode. The most important portion of this function is the if-else is the Save-User-Data. This function calls on two functions in Fire-Base-User, which save the user locally and then to the Firebase.

![](RackMultipart20221111-1-z54yfk_html_15897971b74cd231.png)

_d. Uploading User Images_

![](RackMultipart20221111-1-z54yfk_html_ee685e3d1c1ecbc6.png)

Kobble utilizes the Info-Plist to ask the user for access to the camera of the device. The messages will be prompted to the user so that the user can grant access to the app to access its camera and gallery. In order to utilize the resources of open-source libraries, as mentioned in the opening of the report, the Gallery library is used, which proved functionality for the selection and photo-taking capability of the application. The library is imported and instantiated as Media-Gallery in the Profile-Table-View-Controller. It is used in the Extension of the class to provide support as a gallery of the app. In the Delegate Controller, logic is created to make sure that the user is prompted to select multiple images used as interests. Profile-Table-View-Controller also makes sure that the save button is presented with the editing mode for uploading. The iOS simulator does not provide the capability of taking pictures. In order to test the functionality of the code, the function is used first to upload the images already re-uploaded to the simulator.

Firebase Storage system works like a file directory. In the instance of Kobble, each user's profile image is housed in a folder called Profile-Images. Each image is linked by the user's UID as an identifier. User interest images are housed in a separate folder. To upload user images to the Firebase Storage Upload-Image function is used in the File-Storage file. The sole purpose of the File-Storage file and its class Files-Storage is to upload and download images. The upload-Image function checks for errors and makes sure that when a file is uploaded, and the URL link is received. This allows the user to access the files the next time they return to the application. In the function Upload-Image, key references are instantiated, and upload image quality is compressed so that image quality is standardized and remains in a certain file size capacity.

To connect to the Firebase Storage Directory, a special key is used in the Constants file key file reference, which contains the Firebase Storage URL. This is done for security reasons. A task begins the process and continuously listens for the next upload. To make sure that the task completes, the task checks for errors. When no errors are encountered, Firebase will provide the URL link to the image. Function Upload-Profile-Image is called in the edit mode to do the uploading to a directory for profile images. The image below displays the first image upload for a user.

![](RackMultipart20221111-1-z54yfk_html_95bd0b44884fe52b.png)

To set user images in the application, File-Storage contains a class called Save-Image-locally, which is used to retrieve the URL of the images from the Firebase Storage.

![](RackMultipart20221111-1-z54yfk_html_e19d3450d4572ef1.png)

Kobble ensures that when a user returns to their account, a class function Download-Image provides data necessary to retrieve images belonging to the user. Download-Image function downloads users' data, and their image is once again stored locally.

_e. Uploading Interest Images_

Uploading multiple images is another essential part of the application, which allows the user to add multiple images of their interests. These could be pictures of the user's pets, hobbies, and even locations. This is done with the use of the Upload-Images function in File-Storage. This function creates a directory and stores an array of links in the Interest-Images file. A function that uploads images for interests from Firebase is called Upload-Interests. Below is an image that demonstrates an upload of 4 images, and on the left is the view of the gallery library and its functionality.

![](RackMultipart20221111-1-z54yfk_html_b7b2beb0b89a393e.png)

_f. User Settings_

The setting portion of the profile resides in the functionality of the settings button. It allows the user to change their email and their username. Additionally, the user will have a name that will be nonmodifiable. One of the critical features is users' ability to change their passwords and email in their profiles. Additionally, the setting portion contains the user's capability to log out. This functionality is implemented with a class function Log-Out-Current-User by removing the current object user and catching any errors in the process. In Profile-Table-View, the functionality is implemented by making sure the user is then prompted with the Login-View.

![](RackMultipart20221111-1-z54yfk_html_e91b624691de63a3.png)

**Final State for Profile View**

![](RackMultipart20221111-1-z54yfk_html_699f72fdc4e1b590.png) ![](RackMultipart20221111-1-z54yfk_html_152cfa53de7f84c8.png)

**III. Shuffle View Implementation**

_a. Library Implementation_

To implement a card type of view when exploring for users to match with a GitHub Shuffle library utilized called Shuffle iOS. Whin the Sample-Shuffle file of the Library, the Sample-Card-Model shows the inputs which the Sample-Card can take on as an example. The modeling of Kobble card view is developed by utilizing the example. These classes are developed with the use of UI-Kit. User-Card-Model file houses the model of the card, User-Card-Overlay is a UI-View model of features on the card which are prevalent to guide the user. User-Card-Content-View is another UI-View class that creates the card view and looks like the gradient overlay at the bottom of the card. User-Card-Footer-View is another UI-View class that creates the title section for the user's name, age, and interests for the card view.

The model takes one of the values of id, name, age, interest, and the profile image in the User-Card-Model. A Firebase-User Object is used to create a card model to pass on the attributes needed for the User-Card-Model. This is done in the Shuffle-View-Controller. When the card is instantiated, the above-mentioned UI-Kit files create the card stylistically. Setting up the image view, the name, tittle, age, and the interest. Below is an image of the

![](RackMultipart20221111-1-z54yfk_html_e957d6e117d27e18.png)

_b. Test Users_

To create test cases for the stack, and array of users and images is crated which are iteratively loads into the Firebase database. These users will be used to create test stack which will then be used model the application behavior in regards to matching of the users. Image below shows how the test users are loaded into Firebase.

![](RackMultipart20221111-1-z54yfk_html_690f9ba36761e5a2.png)

**Resources Used**

Swift

UIKit

CocoaPods

Objective-C

Firebase

TensorFlow

**Conclusion**

The development of a full-stack application can be a difficult process therefore reliance on incremental development will have a productive effect on the development of this project. Each stage of the schedule will have provided some sort of component which will have some functionality for the whole project. As the research and the preparation for this full-stack application could be a tenacious stage, in order to make progress certain features will be prioritized for the minimal viable product.

**REFERENCES** [**(top)**](#top)

1. Rony Rozen Jan 27 2020 · Article (20 mins) · Intermediate, & Rozen, R. (n.d.). _CocoaPods tutorial for swift: Getting started_. raywenderlich.com. Retrieved May 3, 2022, from [https://www.raywenderlich.com/7076593-cocoapods-tutorial-for-swift-getting-started](https://www.raywenderlich.com/7076593-cocoapods-tutorial-for-swift-getting-started)

2. Google. (n.d.). _SDKs and client libraries  |  firebase documentation_. Google. Retrieved May 3, 2022, from [https://firebase.google.com/docs/firestore/client/libraries](https://firebase.google.com/docs/firestore/client/libraries)

3. Relatedcode. (n.d.). _Relatedcode/Progresshud: Progresshud is a lightweight and easy-to-use HUD for IOS._ GitHub. Retrieved May 3, 2022, from [https://github.com/relatedcode/ProgressHUD](https://github.com/relatedcode/ProgressHUD)

4. Mac-Gallagher. (n.d.). _Mac-Gallagher/Shuffle:_ _🔥_ _a multi-directional card swiping library inspired by tinder_. GitHub. Retrieved May 3, 2022, from [https://github.com/mac-gallagher/Shuffle](https://github.com/mac-gallagher/Shuffle)

5. Hyperoslo. (n.d.). _Hyperoslo/gallery:_ _📹_ _your next favorite image and video picker_. GitHub. Retrieved May 3, 2022, from [https://github.com/hyperoslo/Gallery](https://github.com/hyperoslo/Gallery)

6. suzuki-0000. (n.d.). _Suzuki-0000/skphotobrowser: Simple photobrowser/viewer inspired by Facebook, Twitter photo browsers written by swift_. GitHub. Retrieved May 3, 2022, from [https://github.com/suzuki-0000/SKPhotoBrowser](https://github.com/suzuki-0000/SKPhotoBrowser)

7. Dladden. (n.d.). _Dladden/koble\_capstone_. GitHub. Retrieved May 3, 2022, from [https://github.com/dladden/Koble\_Capstone](https://github.com/dladden/Koble_Capstone)

_8. This page requires JavaScript._ Apple Developer Documentation. (n.d.). Retrieved May 3, 2022, from [https://developer.apple.com/documentation/uikit/view\_controllers](https://developer.apple.com/documentation/uikit/view_controllers)

_9. Progresshud is a lightweight and easy-to-use HUD for IOS._ swiftobc. (n.d.). Retrieved May 3, 2022, from [https://swiftobc.com/repo/relatedcode-ProgressHUD-swift-activity-indicator](https://swiftobc.com/repo/relatedcode-ProgressHUD-swift-activity-indicator)

10. Hudson, P. (2019, May 28). _Force unwrapping_. Hacking with Swift. Retrieved May 3, 2022, from [https://www.hackingwithswift.com/sixty/10/4/force-unwrapping](https://www.hackingwithswift.com/sixty/10/4/force-unwrapping)

11. Apple Developer Documentation. (n.d.). UIImageView Class. Retrieved May 3, 2022, from [https://developer.apple.com/documentation/uikit/uiimageview](https://developer.apple.com/documentation/uikit/uiimageview)

12. Kargopolov, S. (2020, April 9). _How to show an alert in swift_. Apps Developer Blog. Retrieved May 3, 2022, from [https://www.appsdeveloperblog.com/how-to-show-an-alert-in-swift/](https://www.appsdeveloperblog.com/how-to-show-an-alert-in-swift/)

13.Google. (n.d.). _Upload files with cloud storage on Apple platforms  |  firebase documentation_. Google. Retrieved May 3, 2022, from [https://firebase.google.com/docs/storage/ios/upload-files](https://firebase.google.com/docs/storage/ios/upload-files)

_14. How to get documents directory in swift_. Cocoacasts. (n.d.). Retrieved May 3, 2022, from https://cocoacasts.com/fm-1-how-to-get-documents-directory-in-swift

_15. Ai makes dating apps great again [updated in September 2021]_. ITRex. (2021, November 26). Retrieved January 23, 2022, from [https://itrexgroup.com/blog/ai-for-dating-apps/#ai-types](https://itrexgroup.com/blog/ai-for-dating-apps/#ai-types)

16. Shi, H. (2020, October 12). _Machine learning for dating apps_. Medium. Retrieved January 24, 2022, from [https://medium.com/swlh/machine-learning-for-dating-apps-b02a6b1cee61](https://medium.com/swlh/machine-learning-for-dating-apps-b02a6b1cee61)

17. Santos, M. (2021, September 22). _Sorting dating profiles with machine learning and python_. Medium. Retrieved January 24, 2022, from [https://towardsdatascience.com/sorting-dating-profiles-with-machine-learning-and-python-51db7a074a25](https://towardsdatascience.com/sorting-dating-profiles-with-machine-learning-and-python-51db7a074a25)

18. Clusterfck - JavaScript Hierarchical Clustering. (n.d.). Retrieved January 25, 2022, from [https://harthur.github.io/clusterfck/](https://harthur.github.io/clusterfck/)
