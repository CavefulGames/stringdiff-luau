# [stringdiff-luau](https://pesde.dev/packages/caveful_games/stringdiff)
A string similarity metric diffing algorithm invented by splinestein for primitive chat bot use.

This is a fork of [splinestein/splinestein-diffing-algorithm](https://github.com/splinestein/splinestein-diffing-algorithm)

Modified for Luau and pesde.

* Link to module: https://www.roblox.com/library/12088663460/StringDiff
* Open source and can be viewed here: https://github.com/splinestein/splinestein-diffing-algorithm/blob/main/stringdiff.lua
* Link to release thread: https://devforum.roblox.com/t/stringdiff-string-similarity-metric-diffing-algorithm/2131245

**How to use?**

Install a package via `pesde`
```sh
pesde add caveful_games/stringdiff
```

I've tested this for primitive chat bot use and it's working nicely.

It is worth mentioning that this will have O(n) complexity if iterating over any dataset, so keep the dataset
small unless you use better querying techniques on the dataset like FTS.

Hope you enjoy. Feel free to suggest any changes.

## TO-DOs
- [ ] Generate `docs` with markdown from moonwave comments for pesde docs (be likely to be released in 0.2.0)
