---
layout: post
date: $DATE
person: $PERSON_FULL_NAME
goal: $GOAL_NAME
tags: $TAGS
category: $PERSON_SHORT_NAME
---

<h3 class="graph-align goal-title">
    <a href="$PROFILE_URL">{{ page.person }}</a>
    ::
    <a href="$GOAL_URL">{{ page.goal }}</a>
</h3>

<br />
<span class="muted graph-align goal-text goal-tags">
        {% for tag in page.tags %}<span>{{ tag }}</span>{% endfor %}
</span>

<br />
<div class="graph-align goal-text goal-description">
      $DESCRIPTION
</div>

[![{{ page.goal }}]($GOAL_GRAPH)]($GOAL_URL)
