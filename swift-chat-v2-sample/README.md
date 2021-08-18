# swift-chat-v2-sample

This sample app demonstrates the login and describe functionality available for [Kustomer Chat 2.0](https://help.kustomer.com/introduction-kustomer-chat-H1xk1Gb8v) in the [Kustomer iOS Chat SDK](https://developer.kustomer.com/chat-sdk/v2-iOS/docs).

## Running the Sample App

To run the project, you'll need Xcode 12+

1. First, [clone](https://docs.github.com/en/github/creating-cloning-and-archiving-repositories/cloning-a-repository-from-github/cloning-a-repository) the [`ios-chat-sdk-samples`](https://github.com/kustomer/ios-chat-sdk-samples) repository.

2. Open `swift-chat-v2-sample.xcodeproj` and navigate to `Constants.swift`. Here you will need to replace the hardcoded values for the API key and JSON Web Token.

3. Insert your API Key. Follow the [instructions](https://developer.kustomer.com/chat-sdk/v2-iOS/docs#manually-generate-the-api-key) to get an API key that has the `org.tracking` role only.

4. Insert your JSON Web Token (every 15 minutes). In production this will come from your backend, but in the sample app, we have a mock network call return the value hard-coded here in `Constants.swift`, which you can generate online and replace every 15 minutes.
    1. To generate tokens, you will first need to get the secret key for your org. 
        1. You can get the secret key by logging into your org in a browser and navigating to `https://[YOUR_ORG_NAME].api.kustomerapp.com/v1/auth/customer/settings` and copying the field named `"secret"`. 
        2. Alternatively, you can use Postman and follow the instructions [here](https://developer.kustomer.com/chat-sdk/v2-iOS/docs/authentication#step-1-generate-a-new-kustomer-api-key) to generate a new API key and then submit a GET request to the Kustomer API. Note that the API key you use on Postman will NOT be same API key you use above for the app, because the permissions it needs are different. The API key to use chat SDK must have `org.tracking` role only, while the API key for requesting the secret key will need `org.admin` and `org.user`. Once you have your secret key, you can save it to generate all your future JWTs.
    2. To generate a new JWT, go to the JWT generator at https://jwt.io/
        1. In the `PAYLOAD: DATA` section, enter the key-value pairs for either `email` or `externalId`, for example, `"externalId": "1234567"` or `"email": "fake@email.com"`
        2. In `PAYLOAD: DATA` section, replace the `iat` value with one created within the last 15 minutess. You can get a current `iat` at https://www.epochconverter.com/ - just copy the value at the top of the page for current Unix epoch time.
        3. In the `VERIFY SIGNATURE` section, replace your-256-bit-secret with the secret key you generated for your Kustomer organization.
        4. Copy the value on the Encoded side (or click Share JWT to copy it to clipboard) and paste the value into the string in `Constants.swift`. Note: if you copied it with the button and the full URL is pasted, remove `"https://jwt.io/#debugger-io?token="` and include the token value only. 
        5. This JWT will be valid for 15 minutes from the iat value time, but when it expires you do not need to start over. If you leave https://jwt.io/ and https://www.epochconverter.com/ open, you can quickly get new JWTs by replacing only the `iat` value in `PAYLOAD:DATA` with the current epoch time.
5. Click run!

## Sample App Functionality

The sample app has three screens, each of which is a UIViewController.

#### Login Screen - `LoginViewController.swift`
The Login screen allows a customer to either:

- Log into the app to view an Order History screen (any email/password combination will succeed), or
- Continue to a Guest screen without any order details

After a successful login, the user is logged into Kustomer Chat, and a describe call is made to add the provided email address to the Customer object of the customer logged into the chat, since it may be different from the email or externalId used to create the JWT for login.

![LoginScreen](/swift-chat-v2-sample/Screenshots/Login.png?raw=true "Login Screen")

#### Order History Screen - `OrderHistoryViewController.swift`
The Order History screen:

- Shows order details for three orders
    - Each order shows a Get Help button that opens a Kustomer conversations and describes that conversation with the order number           
      * **Note**: The sample code calls `Kustomer.chatProvider.describeConversation(...)` with a conversation attribute named `orderId` and a string value to demonstrate describing a conversation with a [custom attribute](https://developer.kustomer.com/chat-sdk/v2-iOS/docs/describe-conversation#use-custom-attributes). This call is expected to fail and show an error toast as-is. To test the `describeConversation` functionality, replace the `orderId` attribute with a custom conversation attribute for your org.
- Creates an in-memory map of the order number to the conversation ID
    - The first tap on Get Help opens a new conversation, but subsequent taps open the existing conversation for that order

![OrderHistoryScreen](/swift-chat-v2-sample/Screenshots/OrderHistory.png?raw=true "Order History Screen")

#### Guest Screen
The Guest screen shows basic interactions with the Kustomer SDK:

- Open the Kustomer Chat widget based on the default [Chat Widget Experience](https://help.kustomer.com/chat-design-Skgvx4KQf#chat-widget-experience) setting for your Kustomer organization (for example, Live Chat, Knowledge Base, or Knowledge Base + Live Chat).
- Open a new conversation
- Open the Kustomer Chat widget with Live Chat only, regardless of the Chat Widget Experience settings for your organization
- Open the Kustomer Chat widget with Knowledge Base only, regardless of the Chat Widget Experience settings for your organization
- Putting your device in dark mode will change all UI to dark mode.

![GuestScreen](/swift-chat-v2-sample/Screenshots/Guest.png?raw=true "Guest Screen")
