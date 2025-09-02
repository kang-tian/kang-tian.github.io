---
layout: default
title: Home
permalink: /
---

# Projects

<p class="text-gray-600 mb-6">Below are selected works grouped by focus area. Click a project to view details.</p>

<div class="grid gap-10">

  <!-- Data Analysis -->
  <section>
    <h2 class="text-2xl font-semibold mb-4 flex items-center gap-2">
      <img src="/assets/icons/chart.svg" alt="Data Analysis" class="w-6 h-6">
      Data Analysis, Visualization, and Modeling (Machine Learning)
    </h2>
    <div class="grid md:grid-cols-2 lg:grid-cols-3 gap-6">
      {% for p in site.data.projects.data_analysis_ml %}
        <div class="bg-white shadow-md rounded-2xl p-5 hover:shadow-xl transition">
          <img src="{{ p.image | default: '/assets/images/default-data.png' }}" 
               alt="{{ p.name }}" 
               class="w-full h-32 object-cover rounded-lg mb-3">
          <h3 class="text-lg font-bold mb-2">
            <a href="{{ p.url }}" class="hover:text-blue-600">{{ p.name }}</a>
          </h3>
          <p class="text-sm text-gray-600">{{ p.description }}</p>
        </div>
      {% endfor %}
    </div>
  </section>

  <!-- Database -->
  <section>
    <h2 class="text-2xl font-semibold mb-4 flex items-center gap-2">
      <img src="/assets/icons/database.svg" alt="Database" class="w-6 h-6">
      Database
    </h2>
    <div class="grid md:grid-cols-2 lg:grid-cols-3 gap-6">
      {% for p in site.data.projects.database %}
        <div class="bg-white shadow-md rounded-2xl p-5 hover:shadow-xl transition">
          <img src="{{ p.image | default: '/assets/images/default-db.png' }}" 
               alt="{{ p.name }}" 
               class="w-full h-32 object-cover rounded-lg mb-3">
          <h3 class="text-lg font-bold mb-2">
            <a href="{{ p.url }}" class="hover:text-blue-600">{{ p.name }}</a>
          </h3>
          <p class="text-sm text-gray-600">{{ p.description }}</p>
        </div>
      {% endfor %}
    </div>
  </section>

  <!-- Programming -->
  <section>
    <h2 class="text-2xl font-semibold mb-4 flex items-center gap-2">
      <img src="/assets/icons/code.svg" alt="Programming" class="w-6 h-6">
      Programming
    </h2>
    <div class="grid md:grid-cols-2 lg:grid-cols-3 gap-6">
      {% for p in site.data.projects.programming %}
        <div class="bg-white shadow-md rounded-2xl p-5 hover:shadow-xl transition">
          <img src="{{ p.image | default: '/assets/images/default-code.png' }}" 
               alt="{{ p.name }}" 
               class="w-full h-32 object-cover rounded-lg mb-3">
          <h3 class="text-lg font-bold mb-2">
            <a href="{{ p.url }}" class="hover:text-blue-600">{{ p.name }}</a>
          </h3>
          <p class="text-sm text-gray-600">{{ p.description }}</p>
        </div>
      {% endfor %}
    </div>
  </section>

</div>
