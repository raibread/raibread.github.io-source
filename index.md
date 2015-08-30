---
layout: default
---
{% for post in site.posts do %}
<h3>
  <a href = "{{ post.url }}">{{ post.title }}</a>
</h3>
<h4>
  {{ post.date | date: '%B %d, %Y' }}
</h4>
<p>{{ post.excerpt}}</p>
<div class="tag_list">
<ul>
  {% for tag in post.tags %}
  <li><a href="/tag/{{ tag }}">{{ tag }}</a></li>
  {% endfor %}
</ul>
</div>
{% endfor %}
