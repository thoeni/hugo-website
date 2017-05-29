+++
date = "2017-05-29T21:45:00Z"
hidden = true
title = "Slack Tube Service"
tags = [ "dev", "projects" ]
+++

*RESTful API exposing TFL data on London underground status in a slack-friendly fashion*

It all started from:

- we need a pet project to work on where we can use Golang
- Slack is cool and it would be nice to integrate with it

And in a few days myself and [Oliver Skånberg](https://twitter.com/oskanberg) ended up creating this small Slack integration (still evolving) which is temporarily being served from a nano EC2 instance for cost saving reasons. I tried with a Kubernetes cluster on Google Cloud but for few requests per month it felt like it was a bit overkilling.
The concept is simple, you ask for the tube status, and the service will reply with a nice Slack-friendly message.

This is what it looks like:

{{< figure src="https://camo.githubusercontent.com/2a3703d424db840b3304b0b80c476408428b809a/687474703a2f2f7777772e616e746f6e696f74726f696e612e636f6d2f646f776e6c6f6164732f747562652e706e67" >}}
<center>*Example of service response within Slack*</center>

Once added the integration as **slash command** con Slack, you can call from any channel or chat the `/tube [tubeLine]` command (where the `tubeLine` is optional).
To add the integration, you need to push your **slack token** to this endpoint:
```json
    PUT https://thoeni.io/api/slack/token/{yourToken}
```

And the endpoint to configure as target for the **slash command** is:
```json
    PUT https://thoeni.io/api/slack/tubestatus
```

{{< figure src="../../images/projects/slack-tube-service/grafana-small.jpg" >}}
<center>*Grafana dashboard monitoring the service*</center>

<a href="https://github.com/thoeni/slack-tube-service" title="Slack Tube Service Github" style="color: #404040;">
  <span class="fa-stack fa-lg">
    <i class="fa fa-circle fa-stack-2x"></i>
    <i class="fa fa-github fa-stack-1x fa-inverse"></i>
  </span>
  <b>Open the project on GitHub!</b>
</a>