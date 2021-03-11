# iOS-OneTimeCode
Fully functional one-time passcode features in Swift using Twilio API

I've been trying to create it for a while and a lot of the tutorials cover small parts of each feature so I decided to share this with everyone so you can focus on developing your app and not with authenitication stuff. Give it a star if you like it :)

### Pre-reqs
- [Heroku account](https://heroku.com)
- [Twilio Account](https://www.twilio.com/console)
- Mac computer with Xcode (Works on Xcode 12 | iOS 14)

### How to run it
Follow the "Setting Up" portion of [**Twilio's Tutorial**](https://www.twilio.com/blog/2018/07/phone-verification-in-ios-with-twilio-verify-and-swift.html) until you finish deploying your Heroku server and added your config variables.

Once completed, download this project and add your Heroku server URL the file `TwilioVerify.swift` file located in the folder `API`:

```swift
private static let baseUrlString = "HEROKU_SERVER_URL"
```
### How it should work:

![walkthrough](https://user-images.githubusercontent.com/20372706/110867812-4465a600-827c-11eb-81ec-669db83ba2fe.gif)

