---
layout: default
title: Home
permalink: /
---

# Projects

Below are selected works grouped by focus area.

## Database
<ul>
{% for p in site.data.projects.database %}
  <li>
    <a href="{{ p.url }}">{{ p.name }}</a> — {{ p.description }}
  </li>
{% endfor %}
</ul>

## Data Analysis, Visualization, and Modeling
<ul>
{% for p in site.data.projects.data_analysis_ml %}
  <li>
    <a href="{{ p.url }}">{{ p.name }}</a> — {{ p.description }}
  </li>
{% endfor %}
</ul>

## Programming
<ul>
{% for p in site.data.projects.programming %}
  <li>
    <a href="{{ p.url }}">{{ p.name }}</a> — {{ p.description }}
  </li>
{% endfor %}
</ul>
