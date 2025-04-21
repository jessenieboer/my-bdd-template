`(:project-tags ("my_project_name")
		:roam-files ("/path/to/this/dir/project/bdd/stories.org")
		:roam-templates (("s" "Idea" plain
				  "${title}"
				  :target (file "/path/to/this/dir/bdd/ideas.txt")
				  :empty-lines 1
				  :immediate-finish)
				 ("e" "Story" entry
				  (file "/path/to/this/dir/bdd/story-template.org")
				  :target (file "/path/to/this/dir/bdd/stories.org"))))
