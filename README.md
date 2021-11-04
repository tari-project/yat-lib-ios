# Yat Partner Integration iOS Framework

This framework is designed to make it easy for Yat partners to integrate the Yat purchase or connect flows into their apps.

## Requirements

- iOS 13.0+
- Swift 5

## Installation

### Using Cocoapods

You can use [CocoaPods](http://cocoapods.org/) to install `YatLib` by adding it to your `Podfile`:

```ruby
use_frameworks!

target 'MyApp' do
    pod 'YatLib', '~> 0.2.2'
end
```

## Setup

1. Create your app, add `YatLib` as a pod dependency as described above, and do a `pod install`.

2. `YatLib` uses deep links to return from the Yat web application back to the application. The URL scheme of the deep link is agreed upon between the Yat development team and the integration partner. Setup your deep links in your project accordingly.

    1. Select your project in the project browser.
    2. Select your app target under `Targets`.
    3. Select the `Info` tab and expand the `URL types` section.
    4. Click the `+` button, and enter the app's URL scheme into the `URL Schemes` text box.

3. Open `SceneDelegate.swift` file, and update and add the below functions:

    ```swift
    import UIKit
    import YatLib

    final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

        func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
            Yat.configuration = YatConfiguration(appReturnLink: "{app_return_link}", organizationName: "{organization_name}", organizationKey: "{organization_key}")
	    }

        func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
            guard let url = URLContexts.first?.url else { return }
            Yat.integration.handle(deeplink: url)
        }

        // ... rest of the implementation ...

    }
	```

    The app return link, organization name, and organization key will be delivered to you by the Yat development team.

    # Usage

    `Yat` is an integration entry point. It contains all tools necessary to configure, style, integrate, and interact with API.

    ## Configuration

    To configure the integration, you need to pass a new configuration to the `Yat.configuration` (please check the Setup section above for more information).

    ## Style

    You can change the style (colors, fonts, etc.) of the UI elements used by the framework by changing values stored in `Yat.style`.

    ## Integration

    `Yat.integration` exposes convenience methods to present a unified UI that allows the user to connect his crypto wallet address to Yat. 

    To show a simple onboarding overlay, you need to:
    ```swift
	    Yat.integration.showOnboarding(onViewController: hostViewController, records: records)
    ```
    Where `hostViewController` is a `UIViewController` which will host the modal overlay, and `records` is an array of `YatRecordInput` structures that will be attached to the user's Yat.

    To properly handle the response after the success. you simply add:
    ```swift
	    Yat.integration.handle(deeplink: url)
    ```
    in `SceneDelagate.swift`. Please check the Setup section above for more information.

    ## API

    `Yat.api` provides all the convenience methods used to directly communicate with the Yat API. Currently, YatLib provides methods that handle API calls listed below:

    `GET /emoji_id/{yat}/{symbol}`

    Fetch all records associated with Yat for the provided symbol.

    To use this endpoint, you should call one of these methods:

    `fetchRecords(forYat yat: String, symbol: String, result: @escaping (Result<LookupEmojiIDWithSymbolResponse, APIError>) -> Void)`

    #### Example - Regular request:
    ```swift
    Yat.api.fetchRecords(forYat: "👒🍥🍬♐🕌", symbol: "XTR") { result in
        switch result {
        case let .success(response):
            // Handle response
        case let .failure(error):
            // Handle failure
        }
    }
    ```

    `fetchRecordsPublisher(forYat yat: String, symbol: String) -> AnyPublisher<LookupEmojiIDWithSymbolResponse, APIError>`

    #### Example - Regular reuqest with Apple's Combine:
    ```swift       
    Yat.api.fetchRecordsPublisher(forYat: "👒🍥🍬♐🕌", symbol: "XTR")
        .sink { completion in
            // Handle completion/failure
        } receiveValue: { response in
            // Handle response
        }
        .store(in: &cancelables)
    ```

    `GET /emoji_id/{yat}/json/{key}`

    Fetch the key-value store associated with provided Yat. It returns a different data set depending on the provided `dataType`.

    To use this endpoint, you should call one of these methods:

    `func fetchFromKeyValueStore<T: LoadJsonDataContainer>(forYat yat: String, dataType: T.Type, result: @escaping (Result<LoadJsonResponse<T>, APIError>) -> Void)`

    #### Example - Regular reuqest:
    ```swift
    Yat.api.fetchFromKeyValueStore(forYat: "👒🍥🍬♐🕌", dataType: VisualizerFileLocations.self) { result in
        switch result {
        case let .success(response):
            // Handle response
        case let .failure(error):
            // Handle failure
        }
    }
    ```

    `func fetchFromKeyValueStorePublisher<T: LoadJsonDataContainer>(forYat yat: String, dataType: T.Type) -> AnyPublisher<LoadJsonResponse<T>, APIError>`

    #### Example - Regular reuqest with Apple's Combine:
    ```swift
    Yat.api.fetchFromKeyValueStorePublisher(forYat: "👒🍥🍬♐🕌", dataType: VisualizerFileLocations.self)
        .sink { completion in
            // Handle completion/failure
        } receiveValue: { response in
            // Handle response
        }
        .store(in: &cancelables)
    ```