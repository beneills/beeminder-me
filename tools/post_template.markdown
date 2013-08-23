---
layout: post
date: $DATE
goal: $GOAL_NAME
---

<h3 class="graph-align goal-title">
    <a href="$GOAL_URL" target="_blank">{{ page.goal }}</a>
</h3>

<br />
<div class="graph-align goal-text goal-description">
      $DESCRIPTION
</div>

[![{{ page.goal }}]($GOAL_GRAPH)]($GOAL_URL)
