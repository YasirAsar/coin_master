# Facebook Messenger configuration

[Back to README](../README.md)

Once the project setup is done. Need to setup facebook messaging chat bot.

## Setting Up facebook App
  - Create facebook developer account and create a app in it.
  - Add messenger product to the app.
  - Create facebook page and add it into the app.
  - Generate facebook page access token in the app messenger settings.
  - Copy that token into our project environment `FACEBOOK_PAGE_ACCESS_TOKEN`.
  - In the Messenger app setting enable `messages and messaging_postbacks` permission(webhook section).
  - Enable Built-in NLP for message pre-processing.

## Adding webhook URL in facebook messenger settings.
  - Only for Local
    - If the project setted up on local, we can't able to use `localhost` in the App settings. Because, over the internet `localhost` will not be accessible.
    - So, we need to install and generate the exposed URL by using [ngrok](https://ngrok.com/download).
    - After installing ngrok. Start ngrok by `ngrok http 4000`.
    - Use the generated URL in the settings
  - If the webhook URL is for production environment. Use the application URL `Examples:-` https://abc.com. 
  - Add the `/api/facebook_webhook` suffix to that URL.
  - Add any secret string as `Verification token`. It will be send on URL verification. We can validate it on our server. Add the same into our Environment variables `FACEBOOK_WEBHOOK_VERIFY_TOKEN`.
  - Once the verification was finished. User will get the automated replies for their messages from the page. Before verifying the URL start the server to handle the request.