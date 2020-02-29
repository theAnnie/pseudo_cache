# PseudoCache

Cache like kv store implemenation made in Elixir.

## How to use it?
First of all you need to start new GenServer. You can do it with
```
{:ok, pid} = PseudoCache.start_link()
```
It is possible to give already created map as an arugment to start_link() function (by defauly, GenServer starts with empty cache/map).

It provides four functions:

1. put(pid, key, element) - puts k/v pair to cache.
2. put(pid, key, element, expiration) - puts k/v pair to cache and removes after expiration time.
3. delete(pid, key) - deletes k/v pair from cache.
4. get(pid, key) - return element associated to given key.