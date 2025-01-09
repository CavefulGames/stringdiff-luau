# stringdiff
A string similarity metric diffing algorithm invented by splinestein for primitive chat bot use.

* Link to module: https://www.roblox.com/library/12088663460/StringDiff
* Open source and can be viewed here: https://github.com/splinestein/splinestein-diffing-algorithm/blob/main/stringdiff.lua
* Link to release thread: https://devforum.roblox.com/t/stringdiff-string-similarity-metric-diffing-algorithm/2131245

**How to use?**

Install a package via `pesde`
```sh
pesde add caveful_games/stringdiff -t luau

pesde install
```

I've tested this for primitive chat bot use and it's working nicely.

It is worth mentioning that this will have O(n) complexity if iterating over any dataset, so keep the dataset
small unless you use better querying techniques on the dataset like FTS.

Hope you enjoy. Feel free to suggest any changes.
