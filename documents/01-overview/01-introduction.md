---
title: Overview
author: Peter Friese
date: May 15th, 2012
category: Introduction
---

Mobile development is a hot topic these days. While some might argue that it is just a hype, I firmly believe mobile is the future. Our lives have become more mobile and - to a certain degree - more flexible. Smart phones and the near ubiquitous availability of the internet (not to be confused with 'the mobile web') have contributed largely to this effect.

Reaching as many users as possible has become more and more important not only for large enterprises but also for the many startups which spring up all around us.

It doesn't come as a big surprise there are so many approaches and solutions for developing cross-platform mobile applications. The number of mobile platforms you have to support in order to reach a significant number of people still is prohibitive for implementing native applications by hand for all of these platforms - at least that's what most people think. Later, we'll have to discuss whether this is true in all cases.

There are many reasons why there are so many tools and frameworks for developing cross-platform mobile applications,the most prominent ones being:

* you want to leverage existing knowledge (e.g. your web development skills)
* you want to avoid learning N new languages
* you want to bypass the app store(s), e.g. to allow for faster updates of your app or due to the nature of the content of your app
* you actually want to deploy your app on multiple platforms

In the upcoming blog posts of this series, I would like to introduce a number of approaches for cross-platform application development. As the number of frameworks and tools seems to be growing rather than shrinking, I'll have to make some choices with respect to which frameworks I am going to present. Here is my personal list of criteria which I will use to guide my decisions:

* is the tool well-known / prominent?
* is the approach interesting / new or unheard of?


Most importantly, I will try to make sure to discuss at least one framework / tool for each of the architectural archetypes of cross-platform mobile applications:

* classic website with responsive design
* webapp built using a widget toolkit that emulates native look and feel
* applications that serve as a kind of display engine for a backend service (either generic or made from a baukasten system)
* webapp wrapped in a native wrapper to gain access to hardware and special features of the smart phone it runs on (hybrid app)
* native shell with interpreter that executes interpreted code (interpreted hybrid app)
* cross-compiled applicatioms
* generated applications

The remainder of this post will serve as a high-level discussion of these architectural archetypes.

### Native ###

To better appreciate the various cross-platform approaches, let's first have a look at how native apps are built. In this series, we will concentrate on non-game apps that display data that has been loaded from a backend (either a public web service or an enterprise backend).

Usually, apps like that are made up of a number of layers:

1. The UI layer is what's visible to the user. Often, data-driven apps use a combination of lists and detail views to let the user explore the data using a drill-down interface.
1. The data access layer handles communication with the backend service(s).
1. Sometimes, apps have client-side application logic, which is located in the controller layer.
1. The backend, in turn, is probably a layered system. For our discussion, however, it is sufficient to see it as a source of information. Nowadays, most web-based services have a JSON-based interface, but you might as well encounter systems that use XML or other data formats to deliver information.

Usually, much of the business logic of an application resides in the backend with the frontend serving as a means to display information and gather user input.

In nearly all cases, the frontend communicates with the backend using a high-level protocol of the internet protocol suite (see http://en.wikipedia.org/wiki/Internet_protocol_suite) such as HTTP, FTP, XMPP, or any other protocol from the application layer of the IP suite. (That's not to say there aren't any applications that don't make use of lower-level protocols, but they are much rarer). Normally, the frontend initiates the communication and the backend sends responses to the client's requests (again, there are cases in which the backend uses push notifications or similar communication channels to initiate a communication with the frontend from the server side, but these cases are rarer).

Here is an illustration of the structure of a native solution:

![Native architecture](/images/cpmd_native.png)

The consequences of this architecture are:

* You only need to write the backend once.
* You need to write the frontend for every platform you want to support (e.g. iOS, Android, Windows Phone, etc.)
* You might even need to write a dedicated version of the app for each form factor (phone, tablet) you want to support.
* Writing the app for each of the native platforms is potentially costly.
* Native apps can make use of almost the entire platform and access all the sensors (at least as long as there is an API for that)
* Native apps are distributed on the respective app store. Both Apple and Microsoft make a point of reviewing your app prior to publication. This takes some time and your app also might get rejected in case you violate any of the app store rules.
* On the bright side of things, you are on the app store which means your app can be found easily (and maybe even get featured). You also get the chance to make money off your app.

Now that we've got this out of the way, let's have a look at the options for building cross-platform mobile applications.

### Classic website with responsive design ###

Although the web originally had been invented by Tim Berners-Lee as a means to publish and link scientific articles and information, it quickly became a platform for applications of various forms. Starting with e-commerce and webshops, we have grown used to using applications on the web to accomplish tasks which had been the domain of desktop applications not long ago. Writing emails and letters, calculating your mortgage and even painting pictures - these all are things you'd never dreamt possible in a web browser just a few years ago but which are possible now thanks to a combination of technolgies like HTML, CSS and JavaScript which is commonly (and not quite correctly) known as HTML 5.

Using web technologies to create mobile applications is an obvious consequence of this development. A mixture of HTML plus CSS and JavaScript makes it poossible to create websites that look good on both a desktop browser and mobile devices. CSS media queries make it easy to react to varying screen resolutions and adjusting the layout and the contents of the site to deliver tailored information for mobile users. Gone are the days you had to use pinch-to-zoom in order to be able to read a web site on your mobile phone. Any self-respecting company should have a mobile landing page, and if your's doesn't you better should stop reading now and do something about it. Go and do it, now. I'll wait for you.

In the past few months, a number of HTML and CSS frameworks dealing with fluent layouts and responsive design have sprung up, making it easier than ever before to come up with a website layout that looks good on both desktop browsers and mobile devices. In an upcoming installment of this series, we will have a deeper look at some of them, but in the meantime, feel free to have a look at these:

* Bootstrap by Twitter
* Foundation by zurb

The architecture of mobile websites is very similar to that of regular websites. Most of the work is done by a web server (and potentially an application server) that runs the (mobile) website and delivers HTML, CSS and a bit of JavaScript to the mobile browser. Your users will use the browser of their smartphone in order to surf your website.

Here is an illustration of the architecture of this approach:

![Server-Side Web Architecture](/images/cpmd_serversideweb.png)

The consequences of this approach are:

* You only need to write the backend once.
* You only need to write the frontend once. At least as long as all the devices you want to target have a built-in browser that's decently modern.
* You might need to tune the CSS for some of the target platforms to make it look good.
* Users arriving at your mobile site because they clicked on a link on their Facebook or Twitter app will be delighted because they can consume your content in-place, without having to leave Facebook or Twitter.
* User arriving on your mobile site because they scanned a QR code will be delighted, too. If you plan on using QR codes, watch this video http://www.youtube.com/watch?v=V2rVYvylvZc and come back again. Then, think about using QR codes again.
* Mobile web sites using this approach usually do not look and feel like a native application.
* No access to most of the hardware sensors and APIs such as the address book, calendar, etc.


### Web app built using a widget toolkit emulating native look and feel ###

If the look and feel of a mobile web site doesn't satisfy your needs, you might consider using a widget toolkit for mobile browsers. Widget toolkits like iUI, jQuery mobile or Sencha Touch emulate the look and feel of native applications, thereby making it a lot easier to use web technologies to create apps that look and feel like native applications.

Roughly speaking, there are two kinds of widget toolkits: ones that focus on the UI and come without frontend application wiring and ones that have a more holistic approach and not only come with good-looking UI elements but also with a full-blown MVC infrastructure.

As always, it depends on your requirements which of the two approaches is the right one for your situation.

Here is an illustration of the architecture of this approach:

![Client-Side Web](/images/cpmd_clientsideweb.png)

The consequences of this approach are:

* You only have to write the backend once.
* You only have to write the frontend once.
* Usually, UI toolkits target one specific platform. Most UI toolkits produce UIs that look similar to iOS, so your apps will look like iOS apps even if they run on Android.
* Depending on your demands, you'll have to tweak the look of the frontend to match the UI standards of the various target platforms.
* Performance usually is sub-par
* No access to most of the hardware sensors and APIs such as the address book, calendar, etc.

### Apps that act as a display engine ###


If your applications follow a very homogenous structure, it might make sense to define the structure and behaviour of the application in a central system and let the frontend application render the layout as specified by this backend system. This makes sense especially for enterprise systems such as SAP where all of the application logic resides in the backend and the frontend serves just as a display engine.

A number of proprietary solutions exist that only work in conjunction with specific backend systems, but there are also frameworks that are more flexible, such as RAPmobile.

??? WHat about MobileRoadie ?? Does it fall into this category as well?

Here is an illustration of this architecture:

The consequences of this architecture are:

* You only have to write the backend once
* Usually, you do not have to write a frontend application, as the vendors of these solutions provide you with a "player" application that your users start in order to connect to your backend. Some solutions provide means to customize this player application and distribute branded versions of the player which then will directly connect to your backend system.
* Most player apps are native apps so you'll get decent performance
* Due to the very nature of this approach, the applications you can build with this approach are somewhat limited with respect to their scope


### Hybrid apps ###

If you are comfortable with either a web-based approach (using a frontend-library such as Bootstrap or Foundation) or a widget toolkit based approach but need access to the hardware sensors of your device or advanced APIs such as the calendar or the phone book, hybrid approaches might be a worthwhile option.

Hybrid frameworks such as PhoneGap basically wrap web-based mobile applications with a native wrapper, allowing you to use most of the phone's hardware sensors and advanced APIs using a JavaScript bridge.

Here is an illustration of this approach:

![Hybrid App Architecture](/images/cpmd_hybridapps.png)

The consequences of this approach are:

* You only need to write the backend once.
* You can write the frontend using your preferred web technologies / frameworks
* UI will not look native unless you spend a lot of time tweaking the looks
* You can use JavaScript to access the hardware of your device
* Performance of your app is the same as with web-based


### Interpreted hybrid apps ###


As should have become clear from the previous section, hybrid apps basically are just a thin wrapper around a mobile web browser which is running a web application. Due to the fact the UI is built on either a web UI framework such as Bootstrap or a widget toolkit such as iUI or Sencha Touch, the look and feel will not be the same as for native applications. If you want to achieve native look and feel while still being able to use web technologies such as JavaScript to write your application, interpreted hybrid applications might be a good approach for you.

The most prominent toolkit in this category is Appcelerator Titanium Mobile, or Titanium for short. It consists of a native library for each supported platform that acts as an adapter layer for the application you write using JavaScript. No matter which platform your application runs on, it will always communicate directly with the Titanium abstraction layer instead of dealing with the platform libraries. This allows you to write your code once and deploy it on all the supported platforms. In an ideal world, no further adjustments would be required, but the truth is you still need to perform a few tweaks to make your app look good on all platforms.

Another tool that helps you create interpreted hybrid apps is Adobe Flash Builder.

Here is an illustration of the architecture of this approach:

![Interpreted apps](/images/cpmd_interpreted.png)

The consequences of this approach are:

* You only need to write your backend once
* You only need to write the frontend once
* Your app uses native widgets, so the UI performance is almost the same as for native applications
* You can use JavaScript to write your application
* Some tweaking is still required to make your application look good on all platforms
* Not all relevant platforms are supported as of now


### Cross-compiled apps ###

Instead of using an embedded web browser or an interpreter to interprete and execute your application code, cross-compilation takes code you write in one language and translates it to code that runs on the target platform. To appreciate this approach, please recall that mobile applications running on the various platforms originally need to be written in very different languages:

* Android apps need to be written in Java
* iOS apps need to be written in Objective-C
* Windows Phone apps need to be written in C#

A very promintent example for a cross-compiler is MonoTouch. It allows you to write code in C# and then translates this code to binary code that can run on the iOS platform. Xamarin, the company behind MonoTouch, also offers MonoDroid, a cross-compiler that allows you to write code in C# and execute it on the Android platform by cross-compiling it to binary code that can execute on the Dalvik VM.

Here is an illustration of the architecture of this approach:

The consequence of this approach are:

* You only need to write your backend once.
* You only need to write significant parts of your frontend once.
* The UI parts of the frontend are still very platform specific, which is why you need to write them for each platform individually.
* Your apps are native and run with native performance.
* You can deploy your apps on the app store / market place.
* You need to write your apps in the language used by the cross-compiler. If you're not familiar with this language, you'll have to learn it.
* You won't be able to leverage your web technology skills.


### Generated apps ###

Code generation takes a description (often called model) and produces a number of artifacts from this description. The description (or model) usually abstracts from the concrete implementation of the application, allowing programmers to concentrate on what they want to achieve instead of having to bother with how to achieve their goals.

In the past, code generators often have been driven by UML models, which might not have been the best idea in all cases. Recently, the advent of domain specific languages (DSLs) and language workbenches such as Xtext or MPS have established a much more pragmatic approach to code generation that actually feels a lot more like programming.

Using a DSL, a programmer can describe an application on a high level, without having to deal with low-level technical issues such as how to fetch data or how to cache it. A code generator will then take the DSL code the programmer has written and translate it into source code for the supported target platforms. The result is a collection of source code projects for each of the supported platforms, e.g. iOS; Android and Windows Phone. These projects can the be build using the respective tools (Xcode, Eclipse and Visual Studio), resulting in truly native applications that can be deployed to the app stores.

There are not many tools or frameworks in this area, but one example is Applause (see applause.github.com).

Here is an illustration if the architecture of this approach:

![Generated Apps](/images/cpmd_generatedapps.png)

The consequences of this approach are:

* You only need to write the backend once
* You only need to write the frontend once
* Integrating manually written code still is an issue (you have to write this code for each of the platforms individually, BTW)
* Native apps, native performance
* Not very mainstream approach
* Only suitable for apps that fall into the category of apps supported by the DSL. Otherwise, you'll have to enhance the DSL and the code generator