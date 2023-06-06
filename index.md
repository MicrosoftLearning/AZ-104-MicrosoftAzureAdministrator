---
title: Online Hosted Instructions
permalink: index.html
layout: home
---

# Content Directory

Required labs files can be [DOWNLOADED HERE](https://github.com/MicrosoftLearning/AZ-104-MicrosoftAzureAdministrator/archive/master.zip)

## Labs

{% assign labs = site.pages | where_exp:"page", "page.url contains '/Instructions/Labs'" %}
| Module | Lab |
| --- | --- | 
{% for activity in labs  %}| {{ activity.lab.module }} | [{{ activity.lab.title }}{% if activity.lab.type %} - {{ activity.lab.type }}{% endif %}]({{ site.github.url }}{{ activity.url }}) |
{% endfor %}

## Demos

{% assign demos = site.pages | where_exp:"page", "page.url contains '/Instructions/Demos'" %}
| Module | Demonstration |
| --- | --- | 
{% for activity in demos  %}| {{ activity.demos.module }} | [{{ activity.demos.title }}{% if activity.demos.type %} - {{ activity.demos.type }}{% endif %}]({{ site.github.url }}{{ activity.url }}) |
{% endfor %}
