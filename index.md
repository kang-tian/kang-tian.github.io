---
layout: default
title: Home
permalink: /
---

# 📁 My Projects

Here are some of my key projects, organized by focus area. Click a card to dive into the details.
<p> &nbsp; </p>

## 💻 Programming

<div class="project-grid">
{% for p in site.data.projects.programming %}
<div class="project-card">
  <a href="{{ p.url }}">
    <h3>⚙️ {{ p.name }}</h3>
    <p><strong>Description:</strong> {{ p.description }}</p>
    {% if p.keywords %}
    <p><strong>Keywords:</strong> {{ p.keywords | join: ', ' }}</p>
    {% endif %}
  </a>
</div>
{% endfor %}
</div>
<p> &nbsp; </p>

## 📊 Data Analysis, Visualization, and Modeling (Machine Learning)

<div class="project-grid">
{% for p in site.data.projects.data_analysis_ml %}
<div class="project-card">
  <a href="{{ p.url }}">
    <h3>🔹 {{ p.name }}</h3>
    <p><strong>Description:</strong> {{ p.description }}</p>
    {% if p.keywords %}
    <p><strong>Keywords:</strong> {{ p.keywords | join: ', ' }}</p>
    {% endif %}
  </a>
</div>
{% endfor %}
</div>
<p> &nbsp; </p>

## 🗄 Database

<div class="project-grid">
{% for p in site.data.projects.database %}
<div class="project-card">
  <a href="{{ p.url }}">
    <h3>💾 {{ p.name }}</h3>
    <p><strong>Description:</strong> {{ p.description }}</p>
    {% if p.keywords %}
    <p><strong>Keywords:</strong> {{ p.keywords | join: ', ' }}</p>
    {% endif %}
  </a>
</div>
{% endfor %}
</div>
<p> &nbsp; </p>

