<p align="center">
    <img src="https://raw.githubusercontent.com/piknotech/TrivialTorch/stable/Logo.png" width=600>
</p>

<p align="center">
    <a href="https://travis-ci.org/piknotech/TrivialTorch">
        <img src="https://travis-ci.org/piknotech/TrivialTorch.svg?branch=stable" alt="Build Status">
    </a>
    <a href="#">
        <img src="https://img.shields.io/badge/Swift-4.1-FFAC45.svg" alt="Swift: 4.1">
    </a>
    <a href="https://github.com/piknotech/TrivialTorch/blob/stable/LICENSE.md">
        <img src="https://img.shields.io/badge/License-MIT-lightgrey.svg" alt="License: MIT">
    </a>
</p>

This is a very simple flashlight for iOS, that nonetheless implements features not available in any flashlight app out there:
- Easy, clean UI
- Focus on main features: Controlling brightness & strobe frequency
- 3D Touch Quick Actions
- iPad support
- Ad-free

<p align="center">
  <img src="https://github.com/piknotech/TrivialTorch/blob/stable/Screenshots.jpg"
      style="width: 8000; height: auto;" alt="Trivial Torch Screenshots">
</p>

## The App Review Story

It was originally intended to release this app on the iOS App Store. The motivation for creating it was that I didn't find any existing app being modern, free, ad-free, 3D-touch-compatible and iPad-ready, so I thought it would surely pass App Review.

### The Rejection

Yet, it was rejected, citing guideline 4.3:

**4.3 Spam**
> Don’t create multiple Bundle IDs of the same app. If your app has different versions for specific locations, sports > teams, universities, etc., consider submitting a single app and provide the variations using in-app purchase. Also avoid piling on to a category that is already saturated; the App Store has enough fart, burp, flashlight, and Kama Sutra apps already. Spamming the store may lead to your removal from the Developer Program.

### My thinking

After numerous chats and a 20 minute call with Apple, it got apparent that Apple wouldn't follow my thinking. That was:

> While the 4.3 guideline clearly disallows "piling on to a category that is already saturated", referencing flashlights as an example, this is not the case here.
>
>Two thoughts:
>
> - The flashlight category is saturated. But it's not saturated with any apps being...
>   - fully free
>   - ad-free, not disturbing the UX at any point
>   - universal, as well as
>   - up-to-date (iOS 11 features, e. g. 3D Touch)
>My app is such an app. There's a reason it's here: No single other app implementing all of these important attributes exists yet (tell me if I'm wrong). My app therefore isn't simply spam as defined in rule 4.3.
>
>- I don't think a general rule banning apps from a category is useful. Consider 100 very bad, useless or outdated apps existing in one category and one new app that is far better than all of them. The latter will be rejected. Why? Because the former were released alongside iOS 2.

I find Apple's position highly criticial, defeating the **base ruleset** of App Review as I see it – only allowing apps that:
- are valuable to any user
- don't exploit or harm the user
- don't infringe anyone's rights or feelings an improper way

What Apple is doing here, is focusing onto the word *flashlight* in the guideline, arguing the category is fully saturated, instead of considering individual cases individually.

They are thereby **blocking new, intuitive concepts by protecting legacy apps**.

I understand the desire to keep the store clean, but that should start with old apps and not with modern concepts that unarguably offer features not available on the app store yet.

### The outcome

Now that *Trivial Torch* is finally rejected, it's released here on GitHub as an alternative to anybody who is looking for a lightweight flashlight app to install themselves using Xcode.

## License
This project is released under the [MIT License](http://opensource.org/licenses/MIT). See [LICENSE.md](https://github.com/piknotech/TrivialTorch/blob/stable/LICENSE.md) for details.
