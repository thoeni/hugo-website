+++
date = "2016-09-26T20:00:00Z"
draft = false
title = "java.net.InetAddress: getLocalHost() slow after MacOS Sierra upgrade?"
+++

So, I don't write often mainly because I don't have much to say, but I hope that this, if not interesting, at least will be useful and **save you a lot of time** in troubleshooting.

<h3>Scenario</h3>
After upgrading to MacOS Sierra, without changing a line of code, my Java application startup time (Tomcat/Spring) went to the roof, like **from 15 seconds** to what, **5 minutes**? Something like that.

I made few hypothesis, like *MacOS Sierra introduced a new filesystem and it f\*cked up my logging library* or *[csrutil](http://macossierra-slow.com/how-to-disable-sip-rootless-system-integrity-protection/) is locking something for unknown security reasons* or [*let's read all the issues that people had with Sierra so far*](http://macpaw.com/how-to/fix-macos-sierra-problems)...

I'm working on a Java application that, at some point, uses a json encoder for logging: in the template one of the logged fields is the hostname of the machine that is producing the log line which, to be printed, required a crazy amount of time to resolve the hostname *(yes, now that I saw the implementation, I know it could be cached)*. All this has been discovered after a deep debugging session with a colleague.

<h3>Diagnosis</h3>
So, I thought I could write a small Java class to make that specific call, and measure the elapsed time, and then ask to few colleagues to run the same code and compare the results... one single call to the `java.net.InetAddress.getLocalHost()` method took ~5000ms on my machine, and ~8ms on my colleagues'.<br/>
If you're experiencing a similar issue, try this out (https://github.com/thoeni/inetTester) and see what happens: if the elapsed time gets close to mine, I may have a good news for you, keep reading.

<h3>Solution</h3>
As expected, the solution to all my problems was on **StackOverflow** ([check this post](http://stackoverflow.com/a/33289897/2728768)): I just had to add to my `/etc/hosts` file a mapping to the canonical `127.0.0.1` address for my laptop hostname, and now I have, for example:
```
127.0.0.1   localhost mbpro.local
::1         localhost mbpro.local
```
This brought the elapsed time back to ~8ms (slightly more the first time you call it) and fixed all my problems.

<s>Unfortunately I couldn't up-vote the solution (which surprisingly has been down-voted by someone, despite I'm apparently at least the third person benefitting from the response), therefore if you have enough points, please do up-vote because it really works!</s>

I decided to publish this solution on [StackOverflow](http://stackoverflow.com/questions/39636792/sbt-test-extremely-slow-on-macos-sierra/39698914#39698914) and I managed to have it up-voted in order to get enough points to go back to the post that helped me and give back the favour: all's well that ends well!

Now go, and resolve your hostname as fast as you can.
