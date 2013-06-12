---
layout: post
date: $DATE
person: $PERSON_FULL_NAME
goal: $GOAL_NAME
tags: $TAGS
category: $PERSON_SHORT_NAME
---

<h3 id="goal-title" class="graph-align">
    <a href="$PROFILE_URL">{{ page.person }}</a>
    ::
    <a href="$GOAL_URL">{{ page.goal }}</a>
</h3>
<br />
<span id="goal-tags" class="muted graph-align">
        {% for tag in page.tags %}<span>{{ tag }}</span>{% endfor %}
</span>

[![{{ page.goal }}]($GOAL_GRAPH)]($GOAL_URL)
