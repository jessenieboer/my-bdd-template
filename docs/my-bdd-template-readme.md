- [What](#what)
  - [Features](#features)
- [Why](#why)
- [For Whom](#for-whom)
- [How](#how)
  - [Requirements](#requirements)
  - [Installation](#installation)
  - [Use](#use)
    - [Overview](#orgf575dbe)
    - [Details](#orgbbe785f)
    - [License](#license)
  - [Development](#development)
    - [Process](#process)
    - [Important Decisions](#important-decisions)
    - [To do](#to-do)
    - [Contributing](#contributing)
- [By Whom](#by-whom)

<h1 align="center">jessenieboer's bdd template</h1>


<a id="what"></a>

# What

My repo template for BDD projects


<a id="features"></a>

## Features

-   Provides instructions for AI to
    -   Generate user stories from unstructured text
    -   Generate Gherkin feature files from user stories
    -   Generate step files from feature files (as long as separate language-specific instructions are also included)
-   Allows for capturing unstructured text
-   Allows for capturing user stories in an org mode format
-   Allows for processing user stories with agenda


<a id="why"></a>

# Why

To provide a good starting point for AI-empowered BDD projects


<a id="for-whom"></a>

# For Whom


<a id="how"></a>

# How


<a id="requirements"></a>

## Requirements


<a id="installation"></a>

## Installation

for an independent project, create repo from git@github.com:jessenieboer/python-bdd-project-template.git

to add as a subdirectory to an existing project, use git subtree:

```
git subtree add --prefix=your_subdir_name git@github.com:jessenieboer/my-bdd-template.git master --squash
```

for integrating template changes:

```
git subtree pull --prefix=your_subdir_name git@github.com:jessenieboer/my-bdd-template.git master --squash
```

add your project name and hard-code paths to user-stories.org, ideas.org, and story-template.org in project.el.

```emacs-lisp
`(:project-tags ("<project_name>")
                :roam-files ("<path to project dir>/bdd/user-stories.org")
                :roam-templates (("s" "Idea" plain
                                  "${title}"
                                  :target (file "<path to project dir>/bdd/ideas.txt")
                                  :empty-lines 1
                                  :immediate-finish)
                                 ("e" "User Story" entry
                                  (file "<path to project dir>/bdd/user-story-template.org")
                                  :target (file "<path to project dir>/bdd/user-stories.org")))
                ...)
```

in ideas.txt and user-stories.org, replace >id< using

```emacs-lisp
(insert (org-id-new))
```

note that for capture stuff to work correctly for a project, you have to create a symlink in <emacs dir>/org-roam/ to the project: in dired, put the cursor on the project's directory, dired-do-symlink, and enter <emacs dir>/org-roam/ when prompted for where to symlink from. this solves issues where you can capture correctly but the nodes don't seem to get indexed and nothing shows up for org-roam-node-find


<a id="use"></a>

## Use


<a id="orgf575dbe"></a>

### Overview

1.  Brainstorm in bdd/ideas.txt
2.  Use AI to generate user stories from ideas.txt
3.  Copy the generated stories to bdd/user-stories.org; replace ">id<" with unique ids
4.  Use AI to generate Gherkin features from user-stories.org
5.  Put feature files into bdd/features
6.  Using additional programming-language-specific instructions (not provided here), use AI to generate step definitions for feature files
7.  Put step definitions in bdd/steps


<a id="orgbbe785f"></a>

### Details

have user-stories.org with story headlines and testable scenarios below that. testable scenarios have accompanying code. if some tests need to be grouped together for context reasons, have a separate test structure tree (sessions/packages/modules/classes) and use noweb stuff to keep things organized

tangle to generate test files?

-   capture requirements

    capture software requirements in either of these forms:
    
    -   **idea:** anything worth writing down
        -   unstructured text
        -   /bdd/ideas.txt
    -   **story:** a more fleshed-out requirement in a specific format
        -   /bdd/stories.org
        -   title + metadata + story text
            -   story text is in the form of "as a <role>, i want <feature> so that <benefit>" to stories.org
            -   title should succinctly describe the desired feature
            -   metadata has to do with work management: :ID: <id> :CATEGORY: task :EFFORT<sub>TYPE</sub>: work :FREQUENCY: once :HAS<sub>DUE</sub><sub>DATE</sub>: no :EFFORT<sub>AMOUNT</sub>: average :BUDGET<sub>IMPACT</sub>: trivial :COMMITMENT: probably :HARD<sub>DATE</sub><sub>DEPENDENCY</sub>: no :SOFT<sub>DATE</sub><sub>DEPENDENCY</sub>: no :HARD<sub>INTERNAL</sub><sub>DEPENDENCY</sub>: no :SOFT<sub>INTERNAL</sub><sub>DEPENDENCY</sub>: no :HARD<sub>EXTERNAL</sub><sub>DEPENDENCY</sub>: no :SOFT<sub>EXTERNAL</sub><sub>DEPENDENCY</sub>: no :EFFORT: 0d :ESTIMATED<sub>COST</sub>: 0 :ACTUAL<sub>EFFORT</sub>: :ACTUAL<sub>COST</sub>:

-   generate stories

    give the ai ai-instructions.org and ask it to generate stories for ideas.txt
    
    review and edit the output, and then combine with any stories you wrote yoursevlf.
    
    record everything in stories.org; replace all instances of >id< with a new org id
    
    ```emacs-lisp
    (defun my-replace-ids-with-uuids ()
      "Replace each instance of '>id<' with a unique new Org ID in the current buffer."
      (interactive)
      (save-excursion
        (goto-char (point-min))
        (while (search-forward ">id<" nil t)
          (replace-match (org-id-new) t t))))
    ```
    
    keep all stories at the same headline level; use tags to categorize and agenda views to sort and filter?
    
    use quotes to denote strings in gherkin step arguments (for sake of clarity)

-   generate scenarios

    give the ai ai-instructions.org and ask it to generate scenarios for stories.org
    
    review and edit the output, and then combine with any scenarios you wrote yourself.
    
    -   could be many scenarios generated from a single user story
    
    at this point, tangle to standalone feature files in /bdd/features. note that you might have to create the directory
    
    running your test framework at this point should give you "Step definition is not found" errors

-   generate tests

    give the ai all your feature files and ask it to generate tests.

-   troubleshooting

    i had an issue where capturing an idea to ideas.txt was giving me "org-fold-region: Calling ‘org-fold-core-region’ with missing SPEC", and changing the roam template's target file from /home/jessenieboer/kingdom/projects to ~/kingdom/projects supposedely fixed it. but i also had an issue with user stories being captured as a second level headline in user-stories.org, rather that a first level. i deleted the existing "check friday" story and then it stopped forcing second-level headlines. after experimentation, it seems the issue is that you need file level properties drawers with ids in it for org-roam, so i added that with the placeholder >id< to ideas.txt and user-stories.org, which you must replace with an actual org id using (insert (org-id-new))


<a id="license"></a>

### License


<a id="development"></a>

## Development


<a id="process"></a>

### Process


<a id="important-decisions"></a>

### Important Decisions


<a id="to-do"></a>

### To do

Edit use details


<a id="contributing"></a>

### Contributing


<a id="by-whom"></a>

# By Whom
