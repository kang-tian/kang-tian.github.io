---
layout: default
title: Home
permalink: /
---

# Projects

Below are selected works grouped by focus area.


## Data Analysis, Visualization, and Modeling
<ul>
{% for p in site.data.projects.data_analysis_visualization_ml %}
  <li>
    <a href="{{ p.url }}">{{ p.name }}</a> — {{ p.description }}
  </li>
{% endfor %}
</ul>

## Database
<ul>
{% for p in site.data.projects.database %}
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
