`(:project-tags ("my_bdd_project_template")
		:roam-files ("~/kingdom/projects/solo-projects/professional-projects/repo-templates/my-bdd-template/bdd/stories.org")
		:roam-templates (("s" "Raw capture" plain
				  "${title}"
				  :target (file "~/kingdom/projects/solo-projects/professional-projects/my-bdd-template/bdd/captures.org")
				  :empty-lines 1
				  :immediate-finish)
				 ("e" "Story" entry
				  (file "~/kingdom/projects/solo-projects/professional-projects/repo-templates/my-bdd-template/bdd/story-template.org")
				  :target (file "~/kingdom/projects/solo-projects/professional-projects/repo-templates/my-bdd-template/bdd/stories.org"))))
