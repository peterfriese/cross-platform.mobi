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

## Getting started


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

### Structure of the App

Before we go on enhancing the application, we should take a look at what we've got so far and familiarize ourselves with the project layout.

The contents of your project are shown on the _App Explorer_. This view usually resides on the left-hand side of Titanium Studio[^fn-reset-prespective].

[^fn-reset-prespective]: Titanium Studio is based on Eclipse and makes use of so-called _Perspectives_. A perspective is just a fancy word for "UI layout". Should you need to reset your window layout, just open the perspective context menu by clicking on the perspective title in the upper right hand corner of the IDE window and select _Reset_.

Despite the fact we just created a very simple "Hello World" application, the project already contains quite a number of files and folders. Let's look at them in turn:

![Hello World project structure](/images/titanium/titanium_helloworld_projectstructure.png)

* __i18n__ - This folder contains localized resources. If you're planning to sell your app in different regions of the world, you should use this to translate the texts you display in your app.
* __Resources__ - Contains all images and source code files that will later make up your application.
	* __android__ - Images that are used just for the Android version of your app.
	* __iphone__ - Images that are used just for the iPhone and iPad version of your app.
	* __mobileweb__ - Images that are used just for the mobile web version of your app.
	* __ui__ - Contains the source code files for your app
		* __common__ - UI elements that are shared for all platforms.
			* __FirstView.js__ - This file contains the view that displays "Hello World"!
		* __handheld__ - Special UI layouts for handheld devices such as smart phones.
		* __tablet__ - Special UI layouts for tablet devices.
	* __app.js__ - The main entry point for your app. It all starts here.
	* __KS_nav_ui.png__ - Icon 
	* __KS_nav_views.png__ - Icon
* __tiapp.xml__ - Your application's manifest file. It contains iimportant information about your project.

### Enhancing the App

Let's enhance the app so it becomes slightly more exciting. Smartphones are personal devices, probably even more so than regular PCs - so each self-respecting "Hello World" app should greet it's user properly. Let's add an input field and a button to allow the user to input their name and be greeted by the app with their name.

As you might have guessed, in order to enhance the UI, you have to change code in _Resources/ui/common/FirstView.js_. Open _FirstView.js_ and you'll see the code that displays "Hello World":

	//FirstView Component Constructor
	function FirstView() {
		//create object instance, a parasitic subclass of Observable
		var self = Ti.UI.createView();
		
		//label using localization-ready strings from <app dir>/i18n/en/strings.xml
		var label = Ti.UI.createLabel({
			color:'#000000',
			text:String.format(L('welcome'),'Titanium'),
			height:'auto',
			width:'auto'
		});
		self.add(label);
		
		//Add behavior for UI
		label.addEventListener('click', function(e) {
			alert(e.source.text);
		});
		
		return self;
	}

	module.exports = FirstView;

Let's first add an input field so the user can enter their name. Titanium supports two different input fields, one for single-line input ([Titanium.UI.TextField](http://docs.appcelerator.com/titanium/2.1/index.html#!/api/Titanium.UI.TextField)), and one for multi-line input ([Titanium.UI.TextArea](http://docs.appcelerator.com/titanium/2.1/index.html#!/api/Titanium.UI.TextArea)). A single-line input field is just right for our purposes.

UI elements in Titanium can be created using one of the many factory methods of [Titanium.UI](http://docs.appcelerator.com/titanium/2.1/index.html#!/api/Titanium.UI-method-createTextArea). These factory methods usually look like this:

	Ti.UI.create<NameOfTheWidgetYouWantToUse>(Dictionary parameters)

and return an instance of the respective widget. The parameters dictionary is optional and lets you specify the values for the attributes of the widget. To create a new single-line text input, add the following code directly above the code that produces the label:

		var textField = Ti.UI.createTextField({
		    borderStyle: Titanium.UI.INPUT_BORDERSTYLE_ROUNDED,
		    hintText: 'Enter your name, please',
		    top: 20,
		    width: 'auto', 
		    height: 'auto'
		});
		self.add(textField);

Next, let's create a simple button that the user can click to have the app greet him. Add the following code directly below the code you just inserted:

		var button = Ti.UI.createButton({
			title: 'Greet',
			top: 50,
		    width : 'auto', 
		    height : 'auto'		
		});
		self.add(button);

With that, we've got our UI elements in place and just need to add some code that produces the greeting. Titanium uses a UI event mechanism that is very similar to what you might know from event-based programming in your browser. Add the following code directly after the code you just inserted:

		button.addEventListener('click', function(e) {
			label.text = 'Hello, ' + textField.value
		});

This will add an event listener to the _click_ event of our button. Whenever the user taps on the button, the code will then read what the user entered into the text field, append it to the text "Hello, " and write the result into the label.

You're probably eager to try the app, so go ahead and run it on the iOS Simulator and also on the Android Emulator. By now, you should know how to do this.


### A Word About Layout

If you've run the app on the iPhone Simulator and the Android Emulator, you probably noticed that the UI layout looks a little broken on Android. This is due to the fact we're using an absolute layout. Unfortunately, the iPhone and Android have different screen sizes and resolutions which makes it hard (if not at all impossible) to get the UI layout right by just using an absolute layout.

Fortunately, Titanium comes with a number of other layout managers that allow us to create UIs that look good on all platforms. Let's fix the Hello World app.

Open _FirstView.js_ and change this line:

		var self = Ti.UI.createView();

to:

		var self = Ti.UI.createView({
			layout: 'vertical'
		});

In _vertical_ layout, all positioning information is interpreted in relation to the preceding elements. That is, the button will now be offset 50 pixels from the text field's bottom. as 50 pixels is a little too much, let's set the button's offset to 20:

		var button = Ti.UI.createButton({
			title: 'Greet',
			top: 20,
		    width : 'auto', 
		    height : 'auto'		
		});
		self.add(button);

Now, the UI should look good on both the iPhone and Android.

Learn more about UI element positioning in the documentation about [Titanium.UI.View](http://docs.appcelerator.com/titanium/2.1/index.html#!/api/Titanium.UI.View-property-layout) and [Transitioning to the New UI Layout System](http://docs.appcelerator.com/titanium/2.1/index.html#!/guide/Transitioning_to_the_New_UI_Layout_System).


### Running the App on Your Device

* Run
	* on iOS device
	* on Android device


## Writing a Simple Data-Driven App

This will be the nucleus for the MusiXplorer app. 

**TODO:** Should I dedicate a separate chapter for the design of the app and some sketching? If so, this should be referenced here.

**TODO:** find out about best practices of how to structure a Titanium app

* Create a simple list view for the artists
* Search field to enter artist name
* Connect to iTunes service
