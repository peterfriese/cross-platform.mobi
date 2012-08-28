---
title: Titanium
author: Peter Friese
date: August 23rd, 2012
category: Overview
---

Titanium is a very popular platform for building cross-platform mobile applications. It originally started out as a framework for programming native mobile applications using the language of the web, JavaScript. Over the past few years, however, Titanium has become much more than just a cross-platform mobile SDK. After having received a hefty funding in YYYY, Appcelerator, the company behind Titanium, not only started to enhance the SDK to support every aspect of mobile apps, but also executed some very clever strategic acquisitions and cooperations. 

In this chapter, we will focus on the Titanium SDK and see how to use it to write apps that look and feel like native applications while at the same time using JavaScript to write all the code.

## Overview

Titanium is a cross-platform mobile development framework that uses a hybrid approach to help you create applications that look and feel like native applications. At the same time, it allows you to write the code for your application just once and then use it for the various platforms. It does so by using a native wrapper for each of the supported platforms.

According to the overview we gave in the introduction, apps built using Titanium are [interpreted hybrid apps](../01-overview/01-introduction.html#interpreted-hybrid-apps).

## Installation

Titanium is a free download from the [official web site](http://www.appcelerator.com/platform/titanium-sdk). Nevertheless, you need to sign up for a developer account in order to download and use the Titanium SDK and Titanium Studio, the Eclipse-based IDE. 

At the time of this writing, using the SDK to write and deploy applications is free. If you intend to use other Appcelerator services such as [Appcelerator Analytics](http://www.appcelerator.com/platform/appcelerator-analytics) or [Appcelerator Cloud Services](http://www.appcelerator.com/cloud), you will to sign up for one of their paid packages. Check the [pricing overview](http://www.appcelerator.com/plans-pricing) for further details.

After signing up and downloading Titanium Studio (which includes Titanium SDK), the installation wizard will guide you through the process of installing Titanium Studio and any other dependencies, most notably the Android SDK and the iOS SDK.

**TODO:** add detailed installation and config instructions later.

## Getting started

A short intro to what we're going to build!

### Creating a New Titanium Project

If you haven't already done so, fire up Titanium Studio. You should be greeted with the Titanium welcome perspective, which helps you perform some basic setup steps such as choosing your preferred color scheme, the type of UI (simple of advanced) and helps you to set up the required SDKs (at the time of this writing: Android, iOS and Mobile Web).

![Titanium Welcome Screen](/images/titanium/titanium_studio_welcome.png)

To start a new project, just click on the _Create Project_ button in the _App Explorer_ view. In the dialog box that appears, choose _Titanium | Titanium Mobile Project_ and click _Next_. In the following screen, enter the following information for your new project:

* _Project name:_ `HelloWorld`
* _App Id:_ `mobi.crossplatform.titanium.hello` (or any other unique reverse URL string)
* _Company/Personal URL:_ `http://cross-platform.mobi` (or URL of your home page)

You can leave all the other settings as they are and click _Next_ to continue.

The next dialog page, _Project Template_, lets you choose among a number of pre-defined project templates. For our first app, let's choose _Single Window Application_ and hit _Finish_.

Titanium will now create the basic project structure for our new project. After a few moments, you should see the following structure in the _App Explorer_:

![Hello World project structure](/images/titanium/titanium_helloworld_projectstructure.png)

### Running the App on Your Computer

Without further ado, let's try running this app. If you've got all SDKs set up properly, you should be able to run the app on the Android Emulator or the iPhone Simulator. If you've got a real device attached, you even should be able to run your app on the device - but we'll keep that for later, as it requires some additional steps.

For now, drop down the _launch menu_ in the _App Explorers_ toolbar and choose _iPhone Simulator_ to run the app on the iPhone Simulator. 

![Running the Hello World app on the iPhone Simulator](/images/titanium/titanium_launch_on_iphone_simulator.png)

The iPhone Simulator should start up in no time and just a second later you will see your app running on the Simulator.

![Hello World, Titanium style](/images/titanium/titanium_helloworld_simulator.png)

Wasn't that easy? Let's try running the app on Android. Again, drop down the _launch menu_, but this time, select _Android Emulator_. The Emulator starts up a little slower than the iPhone Simulator, so you need to be a little bit more patient. After a few moments, you should see your app on the Emulator:

![Hello World, Titanium style - on Android](/images/titanium/titanium_helloworld_emulator.png)

With a few simple steps, you created a cross-platform mobile application with Appcelerator Titanium and you didn't even need to change anything to run this app on the two supported platforms.

In the next section, we'll have a closer look at the app structure as we add a few UI elements to enhance the app and make it a little bit more interesting (and personal).