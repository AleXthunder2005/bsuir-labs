using System.Collections.Concurrent;

namespace TestLibrary.SharedContext;

public static class SharedContextStore
{
    private static ConcurrentDictionary<string, object> _store = new();
    public static void Register(string name, object instance) => _store[name] = instance;

    public static bool TryGet<T>(string name, out T? instance)
    {
        if (_store.TryGetValue(name, out var obj) && obj is T t)
        {
            instance = t; 
            return true;
        }
        instance = default;
        return false;
    }

    public static void Clear() => _store.Clear();

    public static bool Unregister(string name) => _store.TryRemove(name, out _);
}