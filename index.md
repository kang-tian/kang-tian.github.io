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

## Data Visualization
<ul>
{% for p in site.data.projects.data_visualization %}
  <li>
    <a href="{{ p.url }}">{{ p.name }}</a> — {{ p.description }}
  </li>
{% endfor %}
</ul>

## Modeling & Machine Learning
<ul>
{% for p in site.data.projects.modeling_ml %}
  <li>
    <a href="{{ p.url }}">{{ p.name }}</a> — {{ p.description }}
  </li>
{% endfor %}
</ul>
