`(:project-tags ("my_project_name")
		:roam-files ("/path/to/this/dir/project/bdd/stories.org")
		:roam-templates (("s" "Idea" plain
				  "${title}"
				  :target (file "/path/to/this/dir/bdd/ideas.txt")
				  :empty-lines 1
				  :immediate-finish)
				 ("e" "Story" entry
				  (file "/path/to/this/dir/bdd/story-template.org")
				  :target (file "/path/to/this/dir/bdd/stories.org")))
		:agenda-commands (("ln" "Stakeholders: Must this item be finished by a certain date, or else it will fail? (Basics)"
		   tags
		   ((org-agenda-hide-tags-regexp nil)
		    (org-agenda-overriding-header "Must this item be finished by a certain date, or else it will fail?")
		    (org-agenda-sorting-strategy '((tags category-up alpha-up)))
		    (org-agenda-view-columns-initially t)
		    (org-overriding-columns-format "%7CATEGORY(Cat) %30ITEM(Item) %HAS_DUE_DATE(Has due date) %DEADLINE(Due date)")
		    (org-super-agenda-groups '((:auto-tags t)))))

		  ("lc" "Stakeholders: What due dates do we still need to know? (Basics)" tags "HAS_DUE_DATE=\"yes\"&DEADLINE=\"\""
		   ((org-agenda-overriding-header "What due dates do we still need to know?")
		    (org-agenda-view-columns-initially t)
		    (org-overriding-columns-format "%7CATEGORY(Cat) %30ITEM(Item) %DEADLINE(Due date)")
		    (org-agenda-sorting-strategy '((tags tag-up)))
		    (org-super-agenda-groups '((:auto-tags t)))))

		  ("ll" "Manager: What are all the basics? (Basics)" tags "EFFORT_TYPE=\"\"|FREQUENCY=\"\"|EFFORT_TYPE<>\"organization\"&HAS_DUE_DATE=\"\"|HAS_DUE_DATE=\"yes\"&DEADLINE=\"\""
		   ((org-agenda-overriding-header "What are all the basics?")
		    (org-agenda-view-columns-initially t)
		    (org-overriding-columns-format "%7CATEGORY(Cat) %30ITEM(Item) %7EFFORT_TYPE(Effort type) %FREQUENCY(Frequency) %HAS_DUE_DATE(Has due date) %DEADLINE(Due date)")
		    (org-agenda-sorting-strategy '((tags tag-up)))
		    (org-super-agenda-groups '((:auto-tags t)))))

  ;;; Prioritization
		  ("as" "Stakeholders: How beneficial would finishing this item be compared to other items in this project? (Prioritization)" tags "*"
		   ((org-agenda-overriding-header "How beneficial would finishing this item be compared to other items in this project?")
		    (org-agenda-view-columns-initially t)
		    (org-agenda-sorting-strategy '((tags priority-down category-down alpha-up)))
		    (org-overriding-columns-format "%7CATEGORY(Cat) %70ITEM(Item) %6PRIORITY(Value)")
		    (org-super-agenda-groups '((:auto-tags t)))))

		  ("ae" "Team: How much effort would this item take compared to other items in this project? (Prioritization)" tags "PRIORITY<>\"C\"|HAS_DUE_DATE=\"yes\""
		   ((org-agenda-cmp-user-defined 'my-org-cmp-effort-amount)
		    (org-agenda-overriding-header "How much effort would this item take compared to other items in this project?")
		    (org-agenda-view-columns-initially t)
		    (org-overriding-columns-format "%7CATEGORY(Cat) %70ITEM(Item) %8EFFORT_AMOUNT(Effort)")
		    (org-agenda-sorting-strategy '((tags user-defined-up category-down alpha-up)))
		    (org-super-agenda-groups '((:auto-tags t)))))

		  ("an" "Manager: How much impact would this item have on the budget compared to other items in this project? (Prioritization)" tags  "PRIORITY=\"A\"|PRIORITY=\"B\"&EFFORT_AMOUNT=\"less\"|HAS_DUE_DATE=\"yes\""
		   ((org-agenda-cmp-user-defined 'my-org-cmp-budget-impact)
		    (org-agenda-overriding-header "How much impact would this item have on the budget compared to other items in this project?")
		    (org-agenda-view-columns-initially t)
		    (org-overriding-columns-format "%7CATEGORY(Cat) %70ITEM(Item) %8BUDGET_IMPACT(Budget)")
		    (org-agenda-sorting-strategy '((tags user-defined-up category-down alpha-up)))
		    (org-super-agenda-groups '((:auto-tags t)))))

		  ("ac" "All: Are we going to commit effort and/or budget to this? (Prioritization)" tags  "PRIORITY=\"A\"|PRIORITY=\"B\"&EFFORT_AMOUNT=\"less\"|HAS_DUE_DATE=\"yes\""
		   ((org-agenda-cmp-user-defined 'my-org-cmp-effort-amount)
		    (org-agenda-overriding-header "Are we going to commit effort and/or budget to this?")
		    (org-agenda-view-columns-initially t)
		    (org-overriding-columns-format "%7CATEGORY(Cat) %40ITEM(Item) %6PRIORITY(Value) %8EFFORT_AMOUNT(Effort) %COMMITMENT(Commitment) %8BUDGET_IMPACT(Budget)")
		    (org-agenda-sorting-strategy '((tags priority-down user-defined-up)))
		    (org-super-agenda-groups '((:auto-tags t)))))
  ;;; Dependencies

    		  (" " "Manager: What are all the dependencies for this item? (Dependencies)" tags "COMMITMENT=\"yes\""
		   ((org-agenda-cmp-user-defined 'my-org-cmp-commitment)
		    (org-agenda-overriding-header "What are all the dependencies for this item?")
		    (org-agenda-view-columns-initially t)
		    (org-overriding-columns-format "%5CATEGORY(Cat) %30ITEM(Item) %5COMMITMENT(Commitment) %HARD_DATE_DEPENDENCY(Hard Date) %SOFT_DATE_DEPENDENCY(Soft Date) %HARD_INTERNAL_DEPENDENCY(Hard Int) %SOFT_INTERNAL_DEPENDENCY(Soft Int) %HARD_EXTERNAL_DEPENDENCY(Hard Ext) %SOFT_EXTERNAL_DEPENDENCY(Soft Ext)")
		    (org-agenda-sorting-strategy '((tags user-defined-up category-down alpha-up)))
		    (org-super-agenda-groups '((:auto-tags t)))))

		    ;;; Assigning resources

		    ;;; Activity
		  ("ts" "Team: What's on our calendar? (Activity)" agenda
		   "DEADLINE<>\"\""
		   ((org-agenda-overriding-header "What's on the calendar?")
		    (org-agenda-sorting-strategy '((agenda timestamp-up)))
		    (org-agenda-span 'month)
		    (org-agenda-use-time-grid nil)
		    (org-agenda-view-columns-initially t)
		    (org-overriding-columns-format "%7TODO(Timing) %70ITEM(Item)")))
		  
		  ("te" "Team: What should we do now? (Activity)" ;; (agenda
		   tags "COMMITMENT=\"yes\"&HARD_DATE_DEPENDENCY=\"no\"&SOFT_DATE_DEPENDENCY=\"no\"&HARD_INTERNAL_DEPENDENCY=\"no\"&SOFT_INTERNAL_DEPENDENCY=\"no\"&HARD_EXTERNAL_DEPENDENCY=\"no\"&SOFT_EXTERNAL_DEPENDENCY=\"no\"|HAS_DUE_DATE=\"yes\"&DEADLINE<=\"<+1w>\""
		   ((org-agenda-cmp-user-defined 'my-org-cmp-effort-amount)
		    (org-agenda-overriding-header "What should we do now?")
		    (org-agenda-sorting-strategy '((tags user-defined-up tag-up alpha-up)))
		    (org-agenda-view-columns-initially t)
		    (org-overriding-columns-format "%5CATEGORY(Cat) %7TODO(Timing) %40ITEM(Item) %8EFFORT_AMOUNT(Effort) %DEADLINE(Due date)")
		    (org-super-agenda-groups 
		     '((:name "Now"
			      :todo "now"
			      :order 1)
		       (:name "Next"
			      :todo "next"
			      :order 2)
		       (:name "Future"
			      :todo "future"
			      :order 3)
		       (:name "Past"
			      :todo "past"
			      :order 4)))))

		  ("tn" "Team: What should I focus on today? (Activity)" tags		     "COMMITMENT=\"yes\"&HARD_DATE_DEPENDENCY=\"no\"&SOFT_DATE_DEPENDENCY=\"no\"&HARD_INTERNAL_DEPENDENCY=\"no\"&SOFT_INTERNAL_DEPENDENCY=\"no\"&HARD_EXTERNAL_DEPENDENCY=\"no\"&SOFT_EXTERNAL_DEPENDENCY=\"no\"&TODO=\"now\"|HAS_DUE_DATE=\"yes\"&DEADLINE<=\"<today>\""
		   ((org-agenda-cmp-user-defined 'my-org-cmp-effort-amount)
		    (org-agenda-overriding-header "What should I focus on today?")
		    (org-agenda-sorting-strategy '((tags user-defined-up tag-up alpha-up)))
		    (org-agenda-view-columns-initially t)
		    (org-overriding-columns-format "%7TODO(Timing) %40ITEM(Item) %8EFFORT_AMOUNT(Effort) %DEADLINE(Due date)")))
		  ("tb" "Team: What is done with? (Activity)" tags "TODO=\"past\""
		   ((org-agenda-cmp-user-defined 'my-org-cmp-effort-amount)
		    (org-agenda-overriding-header "What is done with?")
		    (org-agenda-skip-function-global nil)
		    (org-agenda-sorting-strategy '((tags user-defined-up tag-up alpha-up)))
		    (org-agenda-view-columns-initially t)
		    (org-overriding-columns-format "%7TODO(Timing) %40ITEM(Item) %8EFFORT_AMOUNT(Effort) %DEADLINE(Due date) %15TAGS(Project)")
		    (org-super-agenda-groups 
		     '((:name "Tasks"
			      :category "task"
			      :order 1)
		       (:name "Routines"
			      :category "routine"
			      :order 2)
		       (:name "Practices"
			      :category "practice"
			      :order 3)))))))
