+++
date = "2017-05-29T21:45:00Z"
hidden = true
title = "Slack Tube Service"
tags = [ "dev", "projects" ]
+++
*RESTful API exposing TFL data on London underground status in a slack-friendly fashion*

<a href="https://github.com/thoeni/slack-tube-service" title="Slack Tube Service Github" style="color: #404040;">
  <span class="fa-stack fa-lg">
    <i class="fa fa-circle fa-stack-2x"></i>
    <i class="fa fa-github fa-stack-1x fa-inverse"></i>
  </span>
  <b>Open the project on GitHub!</b>
</a>

It all started from:

- we need a pet project to work on where we can use Golang
- Slack is cool and it would be nice to integrate with it

And in a few days myself and [Oliver Skånberg](https://twitter.com/oskanberg) ended up creating this small Slack integration (still evolving) which is temporarily being served from a nano EC2 instance for cost saving reasons. I tried with a Kubernetes cluster on Google Cloud but for few requests per month it felt like it was a bit overkilling.
The concept is simple, you ask for the tube status, and the service will reply with a nice Slack-friendly message.

This is what it looks like:

{{< figure src="https://camo.githubusercontent.com/2a3703d424db840b3304b0b80c476408428b809a/687474703a2f2f7777772e616e746f6e696f74726f696e612e636f6d2f646f776e6c6f6164732f747562652e706e67" >}}
<center>*Example of service response within Slack*</center>

To add the integration to your Slack team, you need to push your **slack token** to this endpoint:
```json
    PUT https://services.thoeni.io/api/slack/token/{yourToken}
```
The Slack token will be generated when creating the **slash command** in the custom integrations section of your slack account.
The endpoint to configure as target for the **slash command** is:
```json
    POST https://services.thoeni.io/api/slack/tubestatus
```
Once this is done, you can call from any channel or private chat the `/tube` command. If called without arguments it will return a brief help.
The `/tube` command provides - at this stage - two arguments (or sub-commands) that the bot can interpret:

- `/tube status [tubeLine]` (where the `tubeLine` is optional). The response is not public, so the caller is the only one able to see it. Examples of valid commands are `/tube status` and `/tube status Bakerloo`.

- `/tube subscribe [tubeLine]` (here the `tubeLine` is mandatory). This will store a subscription for the user in order to allow - in the near future - tube status to be queried by username, so you can check whether your colleague `@john` is late for standup because of a tube signal failure on his line!

The service is being monitored through Grafana and Prometheus, and the infrastructure should be totally fine in most cases, but should it become overloaded I'll decide what to do.
{{< figure src="../../images/projects/slack-tube-service/grafana-small.jpg" >}}
<center>*Grafana dashboard monitoring the service*</center>

Last but not least, the service has been developed for personal use, it's currently under active development so there might be times when it will be unavailable.