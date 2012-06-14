---
layout: post
title: "Play!ing with Concordion"
date: 2012-06-14 07:42
comments: true
categories: [playframework, concordion, testing]
---
I've just started experimenting with [Play! framework 2.0](http://www.playframework.org). I was attracted by the static typing and functional nature of [Scala](http://www.scala-lang.org), and the shear testability of Play! applications. It looks like you can test each component of the MVC pattern independently and without going through the UI, and I think in most cases without even starting the server.

As someone who is preaching about testability on a daily basis, I have to investigate further. Of course, the proof of the pudding is in the eating, so I'm going to build and deploy a simple application using it, to see whether it lives up to the promise. I'll track the progress of that application and share any learnings here.
<!--more-->
The first thing I wanted to do was set up a framework for [specifying by example](http://www.specificationbyexample.com) with my current BDD tool of choice which is [Concordion](http://www.concordion.org). Turns out that isn't as straight forward as I thought, since Play! uses [SBT](https://github.com/harrah/xsbt/wiki) (Scala Build Tool), which is new to me, and Concordion has a few quirks in the way it has to be set up. So here's the first of my learnings, which explains how to get Concordion working in a Play! project.

First of all you need to add a dependency on Concordion:

``` scala Build.scala
object ApplicationBuild extends Build {
...
  val appDependencies = Seq(
    "org.concordion" % "concordion" % "1.4.2" % "test"
  )
...
}
```

Next, you need to instruct SBT to copy the Concordion HTML files to the target folder:

``` scala Build.scala
object ApplicationBuild extends Build {
...
   val main = PlayProject(appName, appVersion, appDependencies, mainLang = SCALA).settings(
     unmanagedClasspath in Test <+= (baseDirectory) map { bd => Attributed.blank(bd / "test") }
   )
...
}
```

And last but not least, you probably want to tell Concordion to store it's reports somewhere sensible (otherwise it puts them in the `java.io.tmpdir` folder):

``` scala Build.scala
object ApplicationBuild extends Build {
...
  System.setProperty("concordion.output.dir", "target/test-reports/concordion")
...
}
```

With that in place, you can create a Concordion HTML specification and store it in the `test` folder of your project:

``` html ConcordionExample.html
<!DOCTYPE HTML>
<html xmlns:concordion="http://www.concordion.org/2007/concordion">
<head>
  <title>Concordion Example</title>
</head>
<body>
    <h1>Concordion Example</h1>
    <p>The answer always equals <span concordion:assertEquals="value()">1</span></p>
</body>
</html>
```

Finally, create a Scala or Java fixture class (note that you need to have a dummy method annotated with the [JUnit](http://www.junit.org) `@Test` annotation for the test to be picked up, I haven't found a better way around this yet):

``` scala ConcordionExampleTest.scala
import org.concordion.integration.junit4.ConcordionRunner
import org.junit.runner.RunWith
import org.junit.Test

@RunWith(classOf[ConcordionRunner])
class ConcordionExampleTest {
  def value = 1

  @Test
  def runThisTest() {}
}
```

``` java ConcordionExampleTest.java
import org.concordion.integration.junit4.ConcordionRunner;
import org.junit.runner.RunWith;
import org.junit.Test;

@RunWith(ConcordionRunner.class)
public class ConcordionExampleTest {
    public int value() {
            return 1;
    }

    @Test
    public void runThisTest() {}
}
```

Then you can run `play test` and voila, one Concordion specification is executed!

``` plain $ play test
$ play test
[info] Loading project definition from /Users/craigaspinall/Work/scala-concordion-poc/project
[info] Set current project to scala-concordion-poc (in build file:/Users/craigaspinall/Work/scala-concordion-poc/)
[info] Compiling 1 Scala source to /Users/craigaspinall/Work/scala-concordion-poc/target/scala-2.9.1/test-classes...
[info] ConcordionExampleTest
/Users/craigaspinall/Work/scala-concordion-poc/target/test-reports/concordion/ConcordionExample.html
Successes: 1, Failures: 0

[info] + ConcordionExampleTest.runThisTest
[info] + ConcordionExampleTest.[Concordion Specification for 'ConcordionExample']
[info]
[info]
[info] Total for test ConcordionExampleTest
[info] Finished in 0.526 seconds
[info] 2 tests, 0 failures, 0 errors
[info] Passed: : Total 2, Failed 0, Errors 0, Passed 2, Skipped 0
[success] Total time: 2 s, completed 14/06/2012 8:25:08 AM
```

If anyone reading this knows how to avoid the dummy test, then please leave a comment.