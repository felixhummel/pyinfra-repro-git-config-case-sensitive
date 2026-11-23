# pyinfra git config compares lowercase
Pyinfra compares git config keys against lowercase resulting in diffs even
when there are no logical changes.

To reproduce, run `./run.sh`.

Expected: the second "camelCase key" has no change.

Actual: the second "camelCase key" reports "Success".

This is distracting when you configure git hooks, e.g.
```python
git.config(
    name="foo",
    key="core.hookspath",
    value="/usr/local/lib/foo-hook",
    repo=r.path,
)
```

Output of a run:
```
$ ./run.sh 

----------------[ pyinfra -y @local deploy.py
--> Loading config...
--> Loading inventory...
--> Connecting to hosts...
    [@local] Connected

--> Preparing operation files...
    Loading: deploy.py
    [@local] Ready: deploy.py

--> Skipping change detection
--> Beginning operation run...
--> Starting operation: git init 
    [@local] Success

--> Starting operation: camelCase key 
    [@local] Success

--> Starting operation: lowercase key 
    [@local] No changes

--> Results:
    Operation       Hosts   Success   Error   No Change   
    git init        1       1         -       -           
    camelCase key   1       1         -       -           
    lowercase key   1       -         -       1           
    Grand total     3       2         -       1           

--> Disconnecting from hosts...

----------------[ pyinfra -y @local deploy.py
--> Loading config...
--> Loading inventory...
--> Connecting to hosts...
    [@local] Connected

--> Preparing operation files...
    Loading: deploy.py
    [@local] Ready: deploy.py

--> Skipping change detection
--> Beginning operation run...
--> Starting operation: git init 
    [@local] Success

--> Starting operation: camelCase key 
    [@local] Success

--> Starting operation: lowercase key 
    [@local] No changes

--> Results:
    Operation       Hosts   Success   Error   No Change   
    git init        1       1         -       -           
    camelCase key   1       1         -       -           
    lowercase key   1       -         -       1           
    Grand total     3       2         -       1           

--> Disconnecting from hosts...

```

As `man git-config` states:

> The variable names are case-insensitive, allow only alphanumeric characters
> and -, and must start with an alphabetic character. Some variables may
> appear multiple times; we say then that the variable is multivalued.
