---
layout: post
title: "Something to prove"
date: 2012-06-26 06:57
comments: true
categories: [testing]
---
I am building a simple web application and have set myself the challenge of being able to continuously deploy it to the cloud. To do that, I need to be confident that any changes I make don't break existing functionality. However, the bulk of the application will run in the client using a combination of HTML, CSS and Javascript, and testing those technologies is much more difficult than your typical Java (or JVM based) application. After banging my head against this on and off for several weeks, I was forced to stop and ask myself the question "what is it  that I am actually trying to prove"?

<!-- more -->

I guess at an abstract level I'm trying to prove that there are no unintended side effects for any changes that I make to the application. The application in question is a big visible clock that can be used when facilitating meetings, workshops or events. It's simple in that there is very little logic and no persistence layer, but difficult to test because most of the logic resides on the client, in what most web frameworks would consider to be the view layer.

Whilst [researching](http://aspiringcraftsman.com/2007/08/25/interactive-application-architecture/) how to achieve this, I came across the [Presenter First](http://atomicobject.com/files/PresenterFirstAgile2006.pdf) process and corresponding derivative of the [Model-View-Presenter](http://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93presenter) pattern (which is actually the [Passive View](http://martinfowler.com/eaaDev/PassiveScreen.html) pattern I believe). The goal of Presenter First is to make interactive applications suitable for test driven development, which it does by making the "view" as thin (read dumb or simple) as possible, and pushing all the presentation logic in to the *presenter*, thereby completely isolating the view from the underlying domain model (unlike the traditional Model-View-Controller or Model-View-Presenter pattern). By defining very clear interfaces between the *presenter* and the *model*, and between the *presenter* and the *view*, testability increases tremendously, which is good news for me!

It means that both the model and the view can be mocked, and the interactive behaviour of the application can be tested in isolation. Similarly the business logic can be tested in isolation. The only questions are whether or not the view should be tested and if so, is it possible to automate that testing?

It is certainly true that it can be very difficult to build robust and maintainable automated tests for views. They tend to change more frequently than, and independently of, the underlying application behaviour. The real question is whether or not there is enough value in doing so to get a return on the investment you make in building and maintaining the tests?

In this case I could take the risk and not test the view automatically because both the risk and impact of defects in the view are low. I could run a manual *sanity check* after each commit and confirm that everything still looks OK in production, safe in the knowledge that I can easily roll back the changes in the event that there are issues.

But mine is a small application that is not mission critical to anyone, what about something that is mission critical? I feel like I owe it to the teams that I coach to do this anyway and get an idea of the potential return on investment (or lack thereof) for automating tests for the view. Therefore, in reality, that is what I am trying to prove and where the value will come from, not the testing itself!